class Subject < ApplicationRecord
    has_many :plans
    has_many :users, through: :plans
    def self.search(search)
        @result
        if search
            @result=self.where(course_id: search).or(self.where(subject_id: search))
            if @result=={}
                @result=self.where(subject_id: search)
            end
            if @result=={}
                @result=self.where(teacher: search)
            end
        end
        puts @result
        @result
    end
      
end
