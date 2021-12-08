class EvaluationsController < ApplicationController
  def add
  end

  def edit
  end

  def delete
  end

  # Show a specific evaluation
  def show
    @evaluation = Evaluation.find(params[:id])
  end

  # Get all evaluations for a section
  def index
    @evaluations = Evaluation.where(instructor:current_user.id).where(section:params[:id])
  end
end
