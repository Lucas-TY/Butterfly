class Subject < ApplicationRecord
    # associations
    belongs_to :course
    belongs_to :semester, required: false
    belongs_to :instructor, required: false
    has_many :plans
    has_many :users, through: :plans
    has_many :grading_assignments
    has_many :graders, class_name: 'Student', through: :grading_assignments, foreign_key: "student_id"
    
    def self.search(search)
        @result=[]
        if search
            @result=Subject.joins(:course).where(course: { course_id: search })
            if @result==[]
                @result=self.where(teacher: search)
            end
        end
        puts @result
        @result
    end
      
end
