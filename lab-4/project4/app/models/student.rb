class Student < ApplicationRecord
    # associations
    belongs_to :user
    has_many :evaluations,:dependent => :destroy
    has_many :recommendations,:dependent => :destroy
    has_many :applications,:dependent => :destroy
    has_many :taken_courses
    has_many :courses, through: :taken_courses
    has_many :grading_assignments,:dependent => :destroy
    has_many :sections, class_name: "Subject", foreign_key: "subject_id", through: :grading_assignments
end
