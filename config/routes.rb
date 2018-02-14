Rails.application.routes.draw do
  post '/', to: 'slack_events#index'
end
