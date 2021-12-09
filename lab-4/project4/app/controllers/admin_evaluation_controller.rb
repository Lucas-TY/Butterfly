class AdminEvaluationController < ApplicationController
  def index
    @graders = []
    assignments = GradingAssignment.all
    assignments.each do |assignment|
      evaluation = Evaluation.find_by(student_id:assignment.student_id)
      id = User.find(Student.find(assignment.student_id).user_id)
      if evaluation && !@graders.include?(id)
        @graders.push(id)
      end
    end
  end

  def show
    @student = Student.find_by(user_id:params[:id])
    @evaluations = Evaluation.where(student_id: @student.id)
  end
end
