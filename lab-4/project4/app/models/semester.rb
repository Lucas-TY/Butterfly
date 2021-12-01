class Semester < ApplicationRecord
    # associations
    has_many :sections, class_name: "Subject"
    has_many :applications, class_name: "Application"
end
