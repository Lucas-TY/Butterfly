class SubjectsController < ApplicationController
  before_action :authenticate_user!
  def subjects
    @subjects=Subject.all
  end
end
