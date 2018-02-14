class SlackEventsController < ApplicationController
  # params is a hash like {"token":"...","challenge":"...","type":"..."}
  def index
    render json: params
  end
end
