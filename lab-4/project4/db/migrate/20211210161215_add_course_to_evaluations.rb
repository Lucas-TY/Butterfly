class AddCourseToEvaluations < ActiveRecord::Migration[6.1]
  def change
    add_column :evaluations, :course_id, :string
  end
end
