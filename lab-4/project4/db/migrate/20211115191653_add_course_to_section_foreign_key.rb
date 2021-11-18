class AddCourseToSectionForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :subjects, :course_id
    add_reference :subjects, :course, index: true
  end
end
