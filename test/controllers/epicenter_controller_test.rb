require 'test_helper'

class EpicenterControllerTest < ActionDispatch::IntegrationTest
  test "should get logged_in" do
    get epicenter_logged_in_url
    assert_response :success
  end

  test "should get all_users" do
    get epicenter_all_users_url
    assert_response :success
  end

  test "should get friends" do
    get epicenter_friends_url
    assert_response :success
  end

end
