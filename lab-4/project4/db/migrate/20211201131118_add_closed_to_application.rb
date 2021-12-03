class AddClosedToApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :closed, :string
  end
end
