class AddStudentAndSectionToGradingAssignmentForeginKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :grading_assignments, :grader, index: true
    add_reference :grading_assignments, :section, index: true
  end
end
