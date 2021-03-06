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
    section = Subject.find(params[:subject])
    @user.subjects << section
    @courses = @user.subjects
    if @user.role == "student" && !@user.student.courses.exists?(section.course.id)
      @user.student.courses << section.course
      @user.student.save
    end
    # Adds instructor to a section
    if @user.role == "instructor" && !@user.instructor.sections.exists?(section.id)
      @user.instructor.sections << section
      section.instructor = @user.instructor
      @user.instructor.save
      section.save
    end
    @user.save
    
    render:planner
  end

  def drop
    options_setup
    @user=current_user
    @current_course=@user.subjects
    @current_course.delete(params[:subject])
    @user.subjects=@current_course
    section = Subject.find(params[:subject])
    if @user.role == "student" && @user.student.courses.exists?(section.course.id)
      @user.student.courses.delete section.course
    end
    # Removes section from an instructor
    if @user.role == "instructor" && !@user.instructor.sections.exists?(section.id)
      @user.instructor.sections.delete section
      @user.instructor.save
      section.save
    end
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
