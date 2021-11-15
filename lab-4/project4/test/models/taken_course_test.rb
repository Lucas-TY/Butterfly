require "test_helper"

class TakenCourseTest < ActiveSupport::TestCase

  def setup
    @student = Student.new
    @course = Course.new
  end

  test "add a course to a student" do
    @student.courses << @course
    assert_not @student.courses.empty?
    assert_not @student.taken_courses.empty?
  end

  test "add a student to a course" do
    @course.students << @student
    assert_not @course.students.empty?
    assert_not @course.taken_courses.empty?
    assert_not TakenCourse.all.empty?
  end

end
