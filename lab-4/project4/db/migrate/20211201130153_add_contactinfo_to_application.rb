class AddContactinfoToApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :contact_info, :string
  end
end
