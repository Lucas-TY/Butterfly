class AdminControlsController < ApplicationController
	before_action :authenticate_user!

  # User Actions

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
  
  # Semester Actions

  def show_semesters
    @semesters = Semester.all
  end

  def new_semester
    @semester = Semester.new
  end
  
  def edit_semester
    @semester = Semester.find(params[:id])
    if !@semester
      redirect_to :new_semester
    end
  end

  def create_semester
    @semester = Semester.new semester_params

    if @semester.save
      redirect_to action: :show_semesters
    else
      render 'new_semester'
    end

  end

  def update_semester
    @semester = Semester.find(params[:id])

    if @semester.update semester_params
      redirect_to action: :show_semesters
    else
      render 'new_semester'
    end
  end

  def delete_semester
    @semester = Semester.find(params[:id])
    if !@semester
      flash[:alert] = "Error: #{params[:id]} not found."
    else
      @success = !!(@semester.destroy)
      if !@semester
        flash[:alert] = "Error: #{params[:id]} could not be deleted."
      end
    end
    redirect_to action: :show_semesters
  end

  private def semester_params
    params.require(:semester).permit :code, :description
  end

end
