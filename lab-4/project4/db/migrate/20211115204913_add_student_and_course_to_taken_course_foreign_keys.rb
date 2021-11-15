class AddStudentAndCourseToTakenCourseForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :taken_courses, :student, index: true
    add_reference :taken_courses, :course, index: true
  end
end
