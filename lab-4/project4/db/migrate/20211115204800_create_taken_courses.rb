class CreateTakenCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :taken_courses do |t|

      t.timestamps
    end
  end
end
