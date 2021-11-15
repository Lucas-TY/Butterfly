require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  def setup
    @user1 = User.create! email: "user1@email.com", password: "123456", name: "user1"

    @instructor = Instructor.new

    @user1.instructor = @instructor
  end

  test "instructor should be associated with the user" do 
    @instructor.user = @user1
    @instructor.save!
    assert @user1.instructor == @instructor
    assert_not !!(@user1.student)
  end

  test "instructor should be able to have sections" do
    section1 = Subject.create
    section2 = Subject.create

    @instructor.sections << section1
    @instructor.sections << section2

    assert_not @instructor.sections.empty?
    assert @instructor.sections.size == 2
  end

end
