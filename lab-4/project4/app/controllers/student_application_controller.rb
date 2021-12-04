class StudentApplicationController < ApplicationController
    def application
        @semester_code = selected_semester_params
        puts "#{@semester_code}!!!!!!!!!!!!!!!!!!!!!!"
        @semester = Semester.find_by code: @semester_code
        @user=current_user
        # @courses=@user.subjects
        @subjects=[]
        student=@user.student
        taken_courses=student.courses
        
        if taken_courses.length < 1
            flash.now[:notice] = "You need to add a course to your list of courses taken before beginning an application. You may only apply for courses you have previously taken."
        end
        
        if !@semester
            @subjects = []
            @applications=[]
        else
            # find sections of taken_courses
            taken_courses.each do |course|
                @subjects+=(course.sections.where(semester:@semester).to_a)
            end
            @applications=student.applications.where(semester:@semester)
        end

        puts "hi"
        options_setup
    end


    def edit
        # puts "------------#{params[:subject]}------------"
        if !(params[:subject]=="0")
            # puts "have subject!!!!!!!!!!!!!!!!!!!!"
            @subject=Subject.find(params[:subject])
            course=@subject.course
            @user=current_user
            student=@user.student
            
            if student.applications.where(course_interest:course.course_id).empty?
                @application=Application.new(
                  student:student,
                  availability:"000000000000000000000000000000000000000000000000000000000000",
                  course_interest:course.course_id,
                  semester:@subject.semester,
                  contact_info:"",
                  closed:"False"
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
        semester=Semester.find_by(id:params[:semester])
        puts semester
        puts "!!!!!!!!!!!!!!!!"
        if application
            application.availability=params[:availability]
            application.course_interest=params[:course_interest]
            application.semester=semester
            application.contact_info=params[:contact_info]
            application.closed="False"
            application.save
        else
            Application.create(
              student:current_user.student,
              availability: params[:availability],
              course_interest:params[:course_interest],
              semester:semester,
              contact_info:params[:contact_info],
              closed:"False"
            )
        end
        @user=current_user
        @courses=@user.subjects
        @subjects=[]
        student=@user.student
        # find sections of taken_courses
        @taken_courses=student.courses
        @applications=student.applications
        redirect_to show_application_path({selection:{semester:semester.code}})
    end
    def destory
        Application.find(params[:application]).delete
        redirect_to show_application_path({selection:{semester:params[:code]}}) 
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
