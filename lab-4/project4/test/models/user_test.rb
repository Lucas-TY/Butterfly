require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user1 = User.create! email: "user1@email.com", password: "123456", name: "user1"
    @user2 = User.create! email: "user2@email.com", password: "123456", name: "user2"
    @user3 = User.create! email: "user3@email.com", password: "123456", name: "user3"

    @student = Student.new
    @instructor = Instructor.new
  end

  test "user1 should be linked to student" do
    @user1.student = @student
    @user1.save!

    assert @user1.student == @student
    assert @student.user == @user1
  end

  test "user2 should be linked to an instructor" do
    @user2.instructor = @instructor
    @user2.save!

    assert @user2.instructor == @instructor
    assert @instructor.user == @user2
  end

  test "user3 should no be linked to either a student or an instructor" do
    assert_not !!(@user3.student)
    assert_not !!(@user3.instructor)
  end

end
