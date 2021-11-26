class Semester < ApplicationRecord
    # associations
    has_many :sections, class_name: "Subject", foreign_key: "subject_id"
end
