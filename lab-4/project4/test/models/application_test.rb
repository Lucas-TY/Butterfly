require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def setup
    @user = User.create email: "email@email.com", name: "Test Student", password: "password"
    @student = Student.create user: @user
    @application = Application.create
  end

  test "no applications should be linked to a student by default" do
    assert @student.applications.empty?
  end

  test "application should be linked to a student" do
    @student.applications << @application

    assert_not @student.applications.empty?
    assert @student.applications.find @application.id
    assert @application.student == @student
  end

end
