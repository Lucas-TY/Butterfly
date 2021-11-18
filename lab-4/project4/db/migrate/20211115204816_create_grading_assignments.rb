class CreateGradingAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :grading_assignments do |t|

      t.timestamps
    end
  end
end
