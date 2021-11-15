class AddCourseToSectionForeignKey < ActiveRecord::Migration[6.1]
  def change
    rename_column :subjects, :course_id, :temp
    add_reference :subjects, :course, index: true
  end
end
