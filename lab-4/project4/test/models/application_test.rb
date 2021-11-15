require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def setup
    @student = Student.create
    @application = Application.create
  end

  test "no applications should be linked to a student by default" do
    assert @student.applications.empty?
  end

  test "application should be linked to a student" do
    @student.applications << @application

    assert_not @student.applications.empty?
  end

end
