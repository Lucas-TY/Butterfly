require "test_helper"

class RecommendationTest < ActiveSupport::TestCase

  def setup
    @user1 = User.create email: "email1@email.com", name: "Test Student", password: "password"
    @user2 = User.create email: "email12@email.com", name: "Test Instructor", password: "password"

    @student = Student.create user: @user1
    @instructor = Instructor.create user: @user2
    @recommendation = Recommendation.create

    @student.recommendations << @recommendation
    @instructor.recommendations << @recommendation
  end

  test "recommendation should be linked to a student" do
    assert_not @student.recommendations.empty?
    assert @student.recommendations.find @recommendation.id
  end

  test "recommendation should be linked to an instructor" do
    assert_not @instructor.recommendations.empty?
    assert @instructor.recommendations.find @recommendation.id
  end
end
