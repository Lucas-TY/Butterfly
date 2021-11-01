require "test_helper"

class AdminControlsControllerTest < ActionDispatch::IntegrationTest
  test "should get show_users" do
    get admin_controls_show_users_url
    assert_response :success
  end
end
