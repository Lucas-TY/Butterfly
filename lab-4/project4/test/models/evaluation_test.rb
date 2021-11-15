require "test_helper"

class EvaluationTest < ActiveSupport::TestCase

  def setup
    @student = Student.create
    @instructor = Instructor.create
    @evaluation = Evaluation.create

    @student.evaluations << @evaluation
    @instructor.evaluations << @evaluation
  end

  test "evaluation should be linked to a student" do
    assert_not @student.evaluations.empty?
  end

  test "evaluation should be linked to an instructor" do
    assert_not @instructor.evaluations.empty?
  end

end
