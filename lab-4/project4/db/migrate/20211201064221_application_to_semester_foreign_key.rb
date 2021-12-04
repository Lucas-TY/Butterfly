class ApplicationToSemesterForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :applications , :semester, :Semester
    add_reference :applications, :semester, index: true
  end
end
