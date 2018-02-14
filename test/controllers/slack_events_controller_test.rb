require 'test_helper'

class SlackEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post '/', params: {token: 'hello'}
    assert_response :success
  end

end
