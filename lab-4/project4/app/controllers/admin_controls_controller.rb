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
  	@user.save
  end

end
