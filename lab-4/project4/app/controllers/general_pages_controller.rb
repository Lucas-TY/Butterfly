class GeneralPagesController < ApplicationController
  def home
    # add student to user if user is a student without a corresponding student model
    if current_user && current_user.role == "student" && !current_user.student
      student = Student.new
      current_user.student = student
      student.user = @user
      current_user.save!
      student.save!
    end
  end

  def welcome
  end
end
