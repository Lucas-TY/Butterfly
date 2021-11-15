require "test_helper"

class SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get subjects" do
    get subjects_subjects_url
    assert_response :success
  end
end
