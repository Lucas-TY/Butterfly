require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  def setup
    @user1 = User.create! email: "user1@email.com", password: "123456", name: "user1"

    @instructor = Instructor.create

    @user1.instructor = @instructor
  end

  test "instructor should be associated with the user" do 
    @instructor.user = @user1
    @instructor.save!
    assert @user1.instructor == @instructor
    assert_not !!(@user1.student)
    assert Instructor.find @instructor.id
  end

  test "instructor should be able to have sections" do
    course = Course.create
    section1 = Subject.create course: course
    section2 = Subject.create course: course

    @instructor.sections << section1
    @instructor.sections << section2

    assert_not @instructor.sections.empty?
    assert @instructor.sections.size == 2
    assert @instructor.sections.find section1.id
    assert section1.instructor == @instructor
  end

end
