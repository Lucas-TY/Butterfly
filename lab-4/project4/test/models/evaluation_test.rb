require "test_helper"

class EvaluationTest < ActiveSupport::TestCase

  def setup
    @user1 = User.create email: "email1@email.com", name: "Test Student", password: "password"
    @user2 = User.create email: "email2@email.com", name: "Test Teacher", password: "password"
    @student = Student.create user: @user1
    @instructor = Instructor.create user: @user2
    @evaluation = Evaluation.create

    @student.evaluations << @evaluation
    @instructor.evaluations << @evaluation
  end

  test "evaluation should be linked to a student" do
    assert_not @student.evaluations.empty?
    assert @student.evaluations.find @evaluation.id
  end

  test "evaluation should be linked to an instructor" do
    assert_not @instructor.evaluations.empty?
    assert @instructor.evaluations.find @evaluation.id
  end

end
