class Instructor < ApplicationRecord
    # associations
    belongs_to :user
    has_many :sections, class_name: 'Subject'
    has_many :evaluations ,:dependent => :destroy
    has_many :recommendations,:dependent => :destroy
end
