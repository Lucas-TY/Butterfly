class UserPanelController < ApplicationController
  def planner
    options_setup
    @user = current_user
    @courses = @user.subjects

    @search_result = []

    if params[:search] != ""
      @search_result = Subject.search(params[:search]).select{|section| section.semester.code == params[:semester]}
    end
  end

  def add
    options_setup
    @user=current_user
    @user.subjects<<Subject.find(params[:subject])
    @courses=@user.subjects
    @user.save
    render:planner
  end

  def drop
    options_setup
    @user=current_user
    @current_course=@user.subjects
    @current_course.delete(params[:subject])
    @user.subjects=@current_course
    @courses=@user.subjects
    @user.save
    render:planner
  end

  private def options_setup
    @semester_list = []
    Semester.all.each do |semester|
      @semester_list << [semester.description, semester.code]
    end
  end
  
end
