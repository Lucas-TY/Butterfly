class SubjectsController < ApplicationController
  before_action :authenticate_user!
  
  def subjects
    @subjects = []
    options_setup
  end

  def show_semester
    @semester_code = selected_semester_params
    @semester = Semester.find_by code: @semester_code
    if !@semester
      @subjects = []
    else
      @subjects = @semester.sections
    end
    @current_course = nil
    options_setup
  end

  private def options_setup
    @semester_list = []
    Semester.all.each do |semester|
      @semester_list << [semester.description, semester.code]
    end
  end

  private def selected_semester_params
      if params.has_key? :selection
        selection = params.require(:selection).require(:semester)
      else
        selection = nil
      end
      selection
  end
end
