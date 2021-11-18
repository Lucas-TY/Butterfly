class AddStudentsToApplicationForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_reference :applications, :student, index: true
  end
end
