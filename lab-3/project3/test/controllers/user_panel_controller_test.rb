require "test_helper"

class UserPanelControllerTest < ActionDispatch::IntegrationTest
  test "should get add_subject" do
    get user_panel_add_subject_url
    assert_response :success
  end

  test "should get delete_subject" do
    get user_panel_delete_subject_url
    assert_response :success
  end
end
