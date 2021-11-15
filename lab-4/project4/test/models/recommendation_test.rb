require "test_helper"

class RecommendationTest < ActiveSupport::TestCase

  def setup
    @student = Student.create
    @instructor = Instructor.create
    @recommendation = Recommendation.create

    @student.recommendations << @recommendation
    @instructor.recommendations << @recommendation
  end

  test "recommendation should be linked to a student" do
    assert_not @student.recommendations.empty?
  end

  test "recommendation should be linked to an instructor" do
    assert_not @instructor.recommendations.empty?
  end
end
