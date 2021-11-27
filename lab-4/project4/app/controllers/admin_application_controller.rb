class AdminApplicationController < ApplicationController
    def show
        #we need to show subjects without grader but have application
        @data=[]
        assigneds=GradingAssignment.all
        @assigned_data=[]
        assigneds.each do |assigned|
            student=Student.find(assigned.student_id)
            subject=Subject.find(assigned.subject_id)
            temp={}
            temp["subject"]=subject
            temp["student"]=student
            @assigned_data.append temp
        end
        applications=Application.all
        applications.each do |application|
            temp={}
            subjects=Subject.joins(:course).where("course.course_id":application.course_interest)
            temp["application"]=application
            temp["subjects"]=subjects
            @data.append(temp)
        end
    end
    def assign
        subject=Subject.find(params[:subject])
        application=Application.find(params[:application])
        application.student.sections << subject
        application.delete
        redirect_to :admin_application
    end

end
