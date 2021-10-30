class UserPanelController < ApplicationController
  def planner
    @subjects=Subject.all
    @user=current_user
    @courses=@user.subjects
    @search_result=Subject.search(params[:search])
    @change=params[:subjects]
  end
  def delete_subject
  end
end
