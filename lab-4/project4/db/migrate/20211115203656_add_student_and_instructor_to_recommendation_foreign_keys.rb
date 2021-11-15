class AddStudentAndInstructorToRecommendationForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :recommendations, :student, index: true
    add_reference :recommendations, :instructor, index: true
  end
end
