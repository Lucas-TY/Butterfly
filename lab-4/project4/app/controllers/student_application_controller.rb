class StudentApplicationController < ApplicationController
    def application
        @user=current_user
        @courses=@user.subjects
        @subjects=[]
        student=@user.student

        # find sections of taken_courses
        @taken_courses=student.courses
        @applications=student.applications
        # taken_courses.each do |course|
        #     @subjects+=(course.sections.to_a)
        # end
        puts "hi"
    end
    def edit
        # puts "------------#{params[:subject]}------------"
        if !(params[:subject]=="0")
            # puts "have subject!!!!!!!!!!!!!!!!!!!!"
            course=Subject.find(params[:subject]).course
            @user=current_user
            student=@user.student
            if student.applications.where(course_interest:course.course_id).empty?
                @application=Application.new(
                  student:student,
                  availability:"True",
                  course_interest:course.course_id,
                  semester:"2022 Spring"
                )
            else
                @application=student.applications.where(course_interest:course.course_id)[0]
            end
        else
            # puts "have id!!!!!!!!!!!!!!!!!!!!"
            @application=Application.find(params[:application])
        end
        puts "hiedit"
    end


    def add
        application=Application.find_by(id:params[:id])
        if application
            application.availability=params[:availability]
            application.course_interest=params[:course_interest]
            application.semester=params[:semester]
            application.save
        else
            Application.create(
              student:current_user.student,
              availability: params[:availability],
              course_interest:params[:course_interest],
              semester:params[:semester]
            )
        end
        @user=current_user
        @courses=@user.subjects
        @subjects=[]
        student=@user.student
        # find sections of taken_courses
        @taken_courses=student.courses
        @applications=student.applications
        redirect_to :application
    end
    def destory
        Application.find(params[:application]).delete
        redirect_to :application
    end
end
