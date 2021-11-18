class AddUserForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :students, :user, index: true
    add_reference :instructors, :user, index: true
  end
end
