require "test_helper"

class TakenCourseTest < ActiveSupport::TestCase

  def setup
    @user = User.create email: "email@email.com", name: "Test Student", password: "password"
    @student = Student.new user: @user
    @course = Course.new
  end

  test "add a course to a student" do
    @student.courses << @course
    @student.save!

    assert_not @student.courses.empty?
    assert_not @student.taken_courses.empty?
    assert @student.courses.find @course.id
    assert @course.students.find @student.id
  end

  test "add a student to a course" do
    @course.students << @student
    @course.save!

    assert_not @course.students.empty?
    assert_not @course.taken_courses.empty?
    assert_not TakenCourse.all.empty?
    assert @course.students.find @student.id
    assert @student.courses.find @course.id
  end

end
