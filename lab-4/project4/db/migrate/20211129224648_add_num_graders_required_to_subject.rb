class AddNumGradersRequiredToSubject < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :num_graders_required, :integer
  end
end
