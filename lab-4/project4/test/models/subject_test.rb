require "test_helper"

class SubjectTest < ActiveSupport::TestCase
  def setup
    @section = Subject.create
    @course = Course.create
  end

  test "Section should link to a course" do 
    @section.course = @course
    @section.save!

    assert @section.course == @course
    assert @course.sections.find @section.id
  end

end
