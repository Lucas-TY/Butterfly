require 'json'
require 'pp'
require 'fileutils'

class ScraperController < ApplicationController
  before_action :authenticate_user!
  
  def scrape
    @semester = selected_semester_params
    # scrape information for semester
    %x(bin/rails runner  ./scrapeAndStore/ManageLocalDB.rb "update #{@semester}")
    #redirect_to action: :index, notice: "Finished scrapping #{@semester}!"
  end

  def load
    @semester = selected_semester_params
    down @semester
    loader selected_semester_params
    redirect_to action: :index, notice: "Finished loading #{@semester}!"
  end

  def index
    @semester_list = []
    Semester.all.each do |semester|
      @semester_list << [semester.description, semester.code]
    end
  end

  private def selected_semester_params
    params.require(:selection).require(:semester)
  end

  private def loader(semester_code)
    # Find the selected semester
    semester = Semester.find_by code: semester_code
    if !semester 
      semester = Semester.create code: 0000, description: "Missing Semester"
    end

    # all the json files will be process in this part each iteration we process one course
    checker=File.join("**","scrapeAndStore","result","*.json")
    file_list=Dir.glob(checker)
    file_list.sort!
    file_list.each do |path|
      puts path
      json=File.read(path)
      subs = JSON.parse(json)
      # parse lec and lab relationship
      finding_lab=''
      subs.each do |sub|
          sub["auto_enrolls"]=[]
          if sub['components']=='Laboratory Required, Lecture Required'
              current_subject_id=sub['subject_number']
              if sub['outer_info'][1].include? "Lecture"
                  finding_lab=sub
                  sub["auto_enrolls"]=[]
              else
                  finding_lab["auto_enrolls"].append(current_subject_id)
              end
          end
      end
      subs.each do |sub|
        days=sub["date_times"][0][0]
        temp_elw="#{sub["enroll_total"]}/#{sub["wait_list_total"]}"
        teachers=sub["date_times"][0][2]

        # Find the corresponding course, add the course if it does not yet exist
        course = Course.find_by course_id: sub["course_id"]
        if !course
          course = Course.create course_id: sub["course_id"]
        end

        # Create the section
        section = Subject.create(
          subject_id:sub["subject_number"],
          units_range:sub["units_range"],
          days_times:days,
          room:sub["date_times"][0][1],
          enrld_wait:temp_elw,
          instruct_mode:sub["instruct_mode"],
          open_status:sub["open_status"],
          listed_instructor:teachers,
          semester: semester,
          course: course,
          num_graders_required: 1
        );
        
        # Link the section to the course 
        course.sections << section
        course.save
        # Link the section to the semester
        semester.sections << section
        semester.save
      end
    end
  end

  # remove all of the subjects for the given semester from the databse
  private def down semester_code
    semester = Semester.find_by code: semester_code
    if semester
      Subject.where(semester: semester).destroy_all
    end
  end
  
end
