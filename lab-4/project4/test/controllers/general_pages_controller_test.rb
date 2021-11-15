require "test_helper"

class GeneralPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get general_pages_home_url
    assert_response :success
  end

  test "should get welcome" do
    get general_pages_welcome_url
    assert_response :success
  end
end
