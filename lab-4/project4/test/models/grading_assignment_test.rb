require "test_helper"

class GradingAssignmentTest < ActiveSupport::TestCase
  def setup
    # set up objects that will be linked to the student and section
    @user = User.create email: "email3@email.com", name: "Test Student", password: "password"
    @course = Course.create

    @student = Student.create user: @user
    @section = Subject.create course: @course
    
  end

  test "add a section to a student" do
    @student.sections << @section

    assert_not @student.sections.empty?
    assert @student.sections.find @section.id
    assert_not @student.grading_assignments.empty?
    assert @section.graders.find @student.id
  end

  test "add a student to a section" do
    @section.graders << @student

    assert_not @section.graders.empty?
    assert_not @section.grading_assignments.empty?
    assert_not GradingAssignment.all.empty?
  end
end
