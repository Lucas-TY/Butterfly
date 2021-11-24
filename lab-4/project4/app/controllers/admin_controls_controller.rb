class AdminControlsController < ApplicationController
	before_action :authenticate_user!

  def show_users
		@users = User.all
  end

  def delete_user
    @user = User.find(params[:id])
    @success = !!(@user.destroy)
  end

  def activate_user
    @user = User.find(params[:id])
  	@user.isActive = true
    if @user.role == "instructor"
      @instructor = Instructor.create
      @user.instructor = @instructor
      @instructor.user = @user
      @instructor.save!
      puts @instructor
    end
  	@user.save!
  end

end
