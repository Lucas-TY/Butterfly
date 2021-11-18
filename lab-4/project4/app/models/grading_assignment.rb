class GradingAssignment < ApplicationRecord
    # associations
    belongs_to :grader, class_name: "Student", foreign_key: "student_id"
    belongs_to :section, class_name: 'Subject', foreign_key: "subject_id"
end
