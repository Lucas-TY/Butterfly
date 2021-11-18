class TakenCourse < ApplicationRecord
    # associations
    belongs_to :student
    belongs_to :course
end
