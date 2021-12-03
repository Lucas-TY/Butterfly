class AdminRecommendationController < ApplicationController
    def show_recommendation
        @semester_code = selected_semester_params
        @semester = Semester.find_by code: @semester_code
        # semester=Semester.find_by(id:params[:semester])
        @recommendations=[]
        @assigned_data=[]
        if !@semester
            
        else
            @recommendations=Recommendation.joins(:subject).where("subject.semester_id":@semester.id)

        end
        options_setup
    end


    def assigned_recommendation
        recommendation=Recommendation.find_by(id:params[:recommendation])
        semester=Semester.find_by(id:params[:semester])
        subject=recommendation.subject
        recommendation.student.sections << subject
        recommendation.delete

        redirect_to show_recommendation_path({selection:{semester:semester.code}})
    end

    def reject_recommendation
        recommendation=Recommendation.find_by(id:params[:recommendation])
        semester=Semester.find_by(id:params[:semester])
        recommendation.delete

        redirect_to show_recommendation_path({selection:{semester:semester.code}})
    end


    private def options_setup
        @semester_list = []
        Semester.all.each do |semester|
          @semester_list << [semester.description, semester.code]
        end
    end
    private def selected_semester_params
        if params.has_key? :selection
          selection = params.require(:selection).require(:semester)
        else
          selection = nil
        end
        selection
    end
end
