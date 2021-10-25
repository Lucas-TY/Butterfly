class AdminControlsController < ApplicationController
	before_action :authenticate_user!

  def show_users
		@users = User.all
  end

	private def activate_user(user)
		user.isActive = true
		user.update
	end

end
