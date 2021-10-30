class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.belongs_to :subject
      t.belongs_to :user
      t.datetime :add_date
      t.timestamps
    end
  end
end
