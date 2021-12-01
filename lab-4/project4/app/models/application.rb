class Application < ApplicationRecord
    # associations
    belongs_to :student
    belongs_to :semester
end
