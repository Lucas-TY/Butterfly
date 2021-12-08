class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:edit, :destroy, :show]
  # Make a new evaluation form, need names of graders for dropdown
  def new
    section = Subject.find_by(subject_id:params[:subject])
    assignments = GradingAssignment.where(subject_id:section.id)
    @graders = get_graders(assignments) 
  end

  def edit
  end

  def show
  end

  # Delete an evaluation
  def destroy
    @evaluation.destroy
    redirect_to evaluations_url(subject: params[:subject])
  end

  # Get all evaluations for a section
  def index
    @evaluations = Evaluation.where(instructor:current_user.instructor).where(section:params[:subject])
    
  end

  # Create a new evaluation
  def create
    eval = Evaluation.new()
    assignments = GradingAssignment.where(subject_id:Subject.find_by(subject_id:params[:subject]).id)
    @graders = get_graders(assignments) 
    eval.section = params[:subject]
    eval.message = params[:evaluation]["evaluation"]
    eval.instructor_id = current_user.instructor.id
    eval.student_id = @graders[params[:evaluation]["graders"]]
    eval.save!
    redirect_to evaluations_path(subject: params[:subject])
  end

  private
    # Set the current evaluation being looked at
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    # Get the grader names and ids in a hash
    def get_graders(assignments)
      @graders = {}
      assignments.each do |assignment|
        id = assignment.student_id
        user = User.find(Student.find(id).user_id)
        @graders[user.name] = id
      end
      return @graders
    end
end
