require "test_helper"

class GeneralPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get welcome" do
    get welcome_url
    assert_response :success
  end
end
