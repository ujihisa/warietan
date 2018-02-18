class SlackEventsController < ApplicationController
  # params is a hash like {"token":"...","challenge":"...","type":"..."}
  def index
    if params.dig('type') == 'url_verification'
      render json: {challenge: params.dig('challenge')}
    elsif params.dig('event', 'username') == 'warietan'
      head :ok
    elsif params.dig('event', 'type') == 'message'
      post_params = self.class.react(params)
      if post_params
        system('curl', '-sif', '-d', URI.encode_www_form(post_params), 'https://slack.com/api/chat.postMessage')
      end
      head :ok
    else
      head :ok
    end
  end

  def self.react(params)
    text = params.dig('event', 'text')
    channel = params.dig('event', 'channel')
    case text
    when /\Afriltan (echo|えらんで) /
      {
        token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'],
        channel: channel,
        text: "friltanはいないよ。こっちでどうぞ:\n`warietan #{text.sub(/\Afriltan/, 'warietan')}`"
      }
    when /\Awarietan echo /
      {
        token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'],
        channel: channel,
        text: text[/\Awarietan echo (.*)/, 1],
      }
    when /\Awarietan えらんで /
      candidates = text[/\Awarietan えらんで (.*)/, 1].split
      {
        token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'],
        channel: channel,
        text: candidates.sample,
      }
    else
      nil
    end
  end
end
