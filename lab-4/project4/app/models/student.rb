class Student < ApplicationRecord
    # associations
    belongs_to :user
    has_many :evaluations
    has_many :recommendations
    has_many :applications
    has_many :taken_courses
    has_many :courses, through: :taken_courses
    has_many :grading_assignments
    has_many :sections, class_name: "Subject", foreign_key: "subject_id", through: :grading_assignments
end
