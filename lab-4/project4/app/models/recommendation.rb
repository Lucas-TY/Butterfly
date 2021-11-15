class Recommendation < ApplicationRecord
    # associations
    belongs_to :student
    belongs_to :instructor
end
