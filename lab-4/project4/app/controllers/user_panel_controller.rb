class UserPanelController < ApplicationController
  def planner
    @user=current_user
    @courses=@user.subjects
    @search_result=Subject.search(params[:search])
    if @search_result
      puts "hi"
    end
  end

  def add
    @user=current_user
    @user.subjects<<Subject.find(params[:subject])
    @courses=@user.subjects
    @user.save
    render:planner
  end
  def drop
    @user=current_user
    @current_course=@user.subjects
    @current_course.delete(params[:subject])
    @user.subjects=@current_course
    @courses=@user.subjects
    @user.save
    render:planner
  end
  
end
