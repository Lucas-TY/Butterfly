class AddStudentToEvaluationForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_reference :evaluations, :student, index: true
  end
end
