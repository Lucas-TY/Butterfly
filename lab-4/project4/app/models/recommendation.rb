class Recommendation < ApplicationRecord
    # associations
    belongs_to :student
    belongs_to :instructor
    belongs_to :subject, class_name: 'Subject'
end
