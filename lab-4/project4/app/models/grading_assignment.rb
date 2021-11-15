class GradingAssignment < ApplicationRecord
    # associations
    belongs_to :grader, class_name: "Student"
    belongs_to :section, class_name: 'Subject'
end
