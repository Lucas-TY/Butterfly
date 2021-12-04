class AddLabInfoToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :component, :string
    add_column :subjects, :primary_section, :string
  end
end
