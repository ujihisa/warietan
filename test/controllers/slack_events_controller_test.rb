require 'test_helper'

class SlackEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post '/', params: {token: 'hello'}
    assert_response :success
  end

  test '.react() `echo` posts the given message' do
    post_params = SlackEventsController.react(
      {'event' =>
       {'text' => 'warietan echo hello', 'channel' => 'aaa'}})
    assert_equal(
      {token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'], channel: 'aaa', text: 'hello'},
      post_params)
  end

  test '.react() `えらんで` samples one of given' do
    post_params = SlackEventsController.react(
      {'event' =>
       {'text' => 'warietan えらんで 111 222 333', 'channel' => 'aaa'}})
    assert(
      [
        {token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'], channel: 'aaa', text: '111'},
        {token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'], channel: 'aaa', text: '222'},
        {token: ENV['BOT_USER_OAUTH_ACCESS_TOKEN'], channel: 'aaa', text: '333'}
      ].include?(post_params))
  end
end
