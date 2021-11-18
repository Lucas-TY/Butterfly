class ChangeInstructorToInstructorNameInSubject < ActiveRecord::Migration[6.1]
  def change
    rename_column :subjects, :instructor, :listed_instructor
  end
end
