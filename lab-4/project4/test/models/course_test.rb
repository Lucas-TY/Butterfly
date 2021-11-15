require "test_helper"

class CourseTest < ActiveSupport::TestCase

  def setup
    @section = Subject.create
    @course = Course.create
  end

  test "course should initially contain no sections" do
    assert @course.sections.empty?
  end

  test "section is linked to course" do
    @course.sections << @section
    assert_not @course.sections.empty?
    assert @course.sections.find @section.id
  end

  test "section can be added directly to the course's collection" do
    section = @course.sections.create
    assert @course.sections.find section.id
  end

end
