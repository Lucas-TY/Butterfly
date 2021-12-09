class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:update, :edit, :destroy, :show]
  # Make a new evaluation form, need names of graders for dropdown
  def new
    @graders = get_graders()
  end

  # Send information to update evaluation
  def edit
    @name = User.find(Student.find(@evaluation.student_id).user_id).name
  end

  def update
    @evaluation.message = params["evaluation"][:message]
    @evaluation.save
    redirect_to evaluations_path(@evaluation.section)
  end

  def show
    @name = User.find(Student.find(@evaluation.student_id).user_id).name
    @message = @evaluation.message
  end

  # Delete an evaluation
  def destroy
    @evaluation.destroy
    redirect_to evaluations_url(subject: params[:subject])
  end

  # Get all evaluations for a section
  def index
    @evaluations = Evaluation.where(instructor:current_user.instructor).where(section:params[:subject])
    @graders = get_graders()
  end

  # Create a new evaluation
  def create
    @graders = get_graders()
    eval = Evaluation.new()  
    eval.section = params[:subject]
    if params[:evaluation]["evaluation"].length == 0
      eval.message = "No message given"
    else
      eval.message = params[:evaluation]["evaluation"]
    end
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
    def get_graders()
      @graders = {}
      assignments = GradingAssignment.where(subject_id:Subject.find_by(subject_id:params[:subject]).id)
      assignments.each do |assignment|
        if !(Evaluation.find_by(student_id: assignment.student_id))
          id = assignment.student_id
          user = User.find(Student.find(id).user_id)
          @graders[user.name] = id
        end
      end
      return @graders
    end
end
