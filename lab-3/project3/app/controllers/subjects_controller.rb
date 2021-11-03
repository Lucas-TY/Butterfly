class SubjectsController < ApplicationController

  def subjects
    @subjects=Subject.all
  end
end
