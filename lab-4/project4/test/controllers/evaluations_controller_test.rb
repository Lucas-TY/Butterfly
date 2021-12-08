require "test_helper"

class EvaluationsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get evaluations_add_url
    assert_response :success
  end

  test "should get edit" do
    get evaluations_edit_url
    assert_response :success
  end

  test "should get delete" do
    get evaluations_delete_url
    assert_response :success
  end
end
