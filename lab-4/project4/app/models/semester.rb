class Semester < ApplicationRecord
    # associations
    has_many :sections, class_name: "Subject", dependent: :destroy
    has_many :applications, class_name: "Application", dependent: :destroy
end
