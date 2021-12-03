class AddRecommendationToSection < ActiveRecord::Migration[6.1]
  def change
    remove_column :recommendations, :section_id,:string
    add_reference :recommendations, :subject, index: true
    
  end
end
