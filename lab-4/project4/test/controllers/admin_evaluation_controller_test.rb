require "test_helper"

class AdminEvaluationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_evaluation_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_evaluation_show_url
    assert_response :success
  end
end
