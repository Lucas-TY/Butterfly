require "test_helper"

class SemesterTest < ActiveSupport::TestCase
  def setup 
    @course = Course.create    
    @section = Subject.create course: @course
    @semester = Semester.create code: "123456", description: "Test Semester 2021"
  end

  test "a section can exist without a semester" do
    assert_not @section.semester == @semester
  end

  test "a section can have a semester" do
    @semester.sections << @section
    @section.semester = @semester
    @semester.save!
    @section.save!
    
    section_from_table = Subject.find @section.id

    assert @section.semester == @semester
    assert section_from_table.semester == @semester
    assert @semester.sections.exists? @section.id
  end

end
