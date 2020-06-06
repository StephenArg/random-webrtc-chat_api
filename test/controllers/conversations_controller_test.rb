require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  test "should get find_open_room" do
    get conversations_find_open_room_url
    assert_response :success
  end

  test "should get reopen" do
    get conversations_reopen_url
    assert_response :success
  end

end
