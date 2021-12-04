
class RecommendationsController < ApplicationController
  before_action :set_recommendation, only: %i[ show edit update destroy ]

  # GET /recommendations or /recommendations.json
  def index

    
    @recommendations = Recommendation.all
    @student_list=Student.all
    @student_list = []
    Student.all.each do |student|
      @student_list << [student.user.name,student]
    end
  end

  # GET /recommendations/1 or /recommendations/1.json
  def show
    recommendation =Recommendation.find(params[:id])
  end

  # GET /recommendations/new
  def new
    @recommendation = Recommendation.new
    @operating=params[:operating]
  end

  # GET /recommendations/1/edit
  def edit
  end

  # POST /recommendations or /recommendations.json
  def create
    @recommendation = Recommendation.new(recommendation_params)
    respond_to do |format|
      if @recommendation.save
        format.html { redirect_to recommendations_path(@recommendation.subject.subject_id),id: @recommendation.id, notice: "Recommendation was successfully created." }
        format.json { render :show, status: :created, location: @recommendation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommendations/1 or /recommendations/1.json
  def update
    respond_to do |format|
      if @recommendation.update(recommendation_params)
        format.html { redirect_to recommendations_path(@recommendation.subject.subject_id),section: @section, notice: "Recommendation was successfully updated." }
        format.json { render :show, status: :ok, location: @recommendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendations/1 or /recommendations/1.json
  def destroy
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to recommendations_url, notice: "Recommendation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # CREATE recommendation for a group of students
  def rule
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recommendation_params
      recommendation=params.require(:recommendation)
      selected={}
      puts params
      selected[:instructor]=current_user.instructor
      selected[:student]=User.find(params.require(:recommendation).require(:selection)).student
      selected[:subject]=(Subject.find_by(subject_id: params[:operating]))
      selected[:message]="Defualt message"
      if params.require(:recommendation)[:message]!=""
        selected[:message]=params.require(:recommendation)[:message]
      end
      selected
    end
  private def selected_student_params
      if params.has_key? :selection
        selection = params.require(:selection).require(:student)
      else
        selection = nil
      end
      selection
  end
end

