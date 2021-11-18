class Course < ApplicationRecord
    # associations
    has_many :sections, class_name: 'Subject'
    has_many :taken_courses
    has_many :students, through: :taken_courses
end
