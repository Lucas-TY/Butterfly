class AddInstructorToEvaluationForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_reference :evaluations, :instructor, index: true
  end
end
