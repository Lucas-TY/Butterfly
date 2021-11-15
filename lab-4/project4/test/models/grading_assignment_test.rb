require "test_helper"

class GradingAssignmentTest < ActiveSupport::TestCase
  def setup
    @student = Student.new
    @section = Subject.new
  end

  test "add a section to a student" do
    @student.sections << @section
    assert_not @student.sections.empty?
    assert_not @student.grading_assignments.empty?
  end

  test "add a student to a section" do
    @section.graders << @student
    assert_not @section.graders.empty?
    assert_not @section.grading_assignments.empty?
    assert_not GradingAssignment.all.empty?
  end
end
