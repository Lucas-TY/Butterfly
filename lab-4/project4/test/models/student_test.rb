require "test_helper"

class StudentTest < ActiveSupport::TestCase
  def setup
    @user1 = User.create! email: "user1@email.com", password: "123456", name: "user1"

    @student = Student.new

    @user1.instructor = @instructor
  end

  test "student should be associated with a user" do 
    @student.user = @user1
    @student.save!
    assert @user1.student == @student
    assert_not !!(@user1.instructor)
  end
end
