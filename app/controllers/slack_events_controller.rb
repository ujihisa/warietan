class SlackEventsController < ApplicationController
  # params is a hash like {"token":"...","challenge":"...","type":"..."}
  def index
    # mention:
    # {"token"=>"aFIwScpfjjm7O6KRAXU7rH6h", "team_id"=>"T8YE2DRT3", "api_app_id"=>"A99Q14KPG", "event"=>{"type"=>"message", "user"=>"U98PNCASE", "text"=>"test", "ts"=>"1518935809.000007", "channel"=>"C992P87ED", "event_ts"=>"1518935809.000007"}, "type"=>"event_callback", "event_id"=>"Ev9A72H3PA", "event_time"=>1518935809, "authed_users"=>["U98PNCASE"], "slack_event"=>{"token"=>"aFIwScpfjjm7O6KRAXU7rH6h", "team_id"=>"T8YE2DRT3", "api_app_id"=>"A99Q14KPG", "event"=>{"type"=>"message", "user"=>"U98PNCASE", "text"=>"test", "ts"=>"1518935809.000007", "channel"=>"C992P87ED", "event_ts"=>"1518935809.000007"}, "type"=>"event_callback", "event_id"=>"Ev9A72H3PA", "event_time"=>1518935809, "authed_users"=>["U98PNCASE"]}}
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
