class AddSemesterToEvaluations < ActiveRecord::Migration[6.1]
  def change
    add_column :evaluations, :semester, :string
  end
end
