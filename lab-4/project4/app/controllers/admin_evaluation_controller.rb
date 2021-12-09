class AdminEvaluationController < ApplicationController
  def index
    @graders = []
    assignments = GradingAssignment.all
    assignments.each do |assignment|
      if Evaluation.find_by(student_id:assignment.student_id)
        @graders.push(User.find(Student.find(assignment.student_id).user_id))
      end
    end
  end

  def show
  end
end
