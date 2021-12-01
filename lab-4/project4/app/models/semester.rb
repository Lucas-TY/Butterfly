class Semester < ApplicationRecord
    # associations
    has_many :sections, class_name: "Subject"
end
