class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.string :section
      t.string :message

      t.timestamps
    end
  end
end
