class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :availability
      t.string :course_interest
      t.string :semester

      t.timestamps
    end
  end
end
