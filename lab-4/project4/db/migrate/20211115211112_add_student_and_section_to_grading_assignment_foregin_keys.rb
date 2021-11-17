class AddStudentAndSectionToGradingAssignmentForeginKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :grading_assignments, :student, index: true
    add_reference :grading_assignments, :subject, index: true
  end
end
