class SlackEventsController < ApplicationController
  # params is a hash like {"token":"...","challenge":"...","type":"..."}
  def index
    # mention:
    # {"token"=>"aFIwScpfjjm7O6KRAXU7rH6h", "team_id"=>"T8YE2DRT3", "api_app_id"=>"A99Q14KPG", "event"=>{"type"=>"message", "user"=>"U98PNCASE", "text"=>"test", "ts"=>"1518935809.000007", "channel"=>"C992P87ED", "event_ts"=>"1518935809.000007"}, "type"=>"event_callback", "event_id"=>"Ev9A72H3PA", "event_time"=>1518935809, "authed_users"=>["U98PNCASE"], "slack_event"=>{"token"=>"aFIwScpfjjm7O6KRAXU7rH6h", "team_id"=>"T8YE2DRT3", "api_app_id"=>"A99Q14KPG", "event"=>{"type"=>"message", "user"=>"U98PNCASE", "text"=>"test", "ts"=>"1518935809.000007", "channel"=>"C992P87ED", "event_ts"=>"1518935809.000007"}, "type"=>"event_callback", "event_id"=>"Ev9A72H3PA", "event_time"=>1518935809, "authed_users"=>["U98PNCASE"]}}
    if params.dig('event', 'username') == 'warietan'
      render json: params
    elsif params.dig('event', 'type') == 'message'
      text = params.dig('event', 'text')
      channel = params.dig('event', 'channel')
      post_params = {
        token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'],
        channel: channel,
        text: text,
      }
      system('curl', '-sif', '-d', URI.encode_www_form(post_params), 'https://slack.com/api/chat.postMessage')
      render json: params
    else
      render json: params
    end
  end
end
