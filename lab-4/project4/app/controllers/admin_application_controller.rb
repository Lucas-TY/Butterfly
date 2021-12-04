class AdminApplicationController < ApplicationController

    
    def show
        @days_of_week = ["Mon", "Tue", "Wed", "Thr", "Fri"]
        @semester_code = selected_semester_params
        @semester = Semester.find_by code: @semester_code
        # semester=Semester.find_by(id:params[:semester])
        @data=[]
        @assigned_data=[]
        if !@semester
            
        else
            assigneds=GradingAssignment.all
            assigneds.each do |assigned|
                student=Student.find(assigned.student_id)
                subject=Subject.find(assigned.subject_id)
                # not this semester, next
                if !(subject.semester.id==@semester.id)
                    next
                end
                
                temp={}
                temp["subject"]=subject
                temp["student"]=student
                @assigned_data.append temp
            end
            applications=Application.where(semester:@semester).where(closed:"False")
            applications.each do |application|
                temp={}
                subjects=Subject.where(semester:application.semester).joins(:course).where("course.course_id":application.course_interest)
                temp["application"]=application
                temp["subjects"]=subjects
                @data.append(temp)
            end
        end
        #we need to show subjects without grader but have application

        options_setup
    end
    def assign
        subject=Subject.find(params[:subject])
        application=Application.find(params[:application])
        application.student.sections << subject
        application.closed="True"
        application.save
        redirect_to admin_application_path({selection:{semester:subject.semester.code}})
    end
    def reject
        application=Application.find(params[:application])
        application.closed="Rejected"
        application.save
        redirect_to admin_application_path({selection:{semester:application.semester.code}})
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
