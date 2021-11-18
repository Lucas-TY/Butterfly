class AddIsActiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :isActive, :boolean
  end
end
