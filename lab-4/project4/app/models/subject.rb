class Subject < ApplicationRecord
    # associations
    belongs_to :course
    belongs_to :semester, required: false
    belongs_to :instructor, required: false
    has_many :plans
    has_many :recommendations
    has_many :users, through: :plans
    has_many :grading_assignments
    has_many :graders, class_name: 'Student', through: :grading_assignments, foreign_key: "student_id"
    
    def self.search(search)
        @result=[]
        @search=search
        if search
            @result=Subject.joins(:course).where(course: { course_id: @search })
            @result|=Subject.where( listed_instructor: @search)
            @result|=Subject.where( subject_id: @search)
            
        end
        @result
    end
      
end
