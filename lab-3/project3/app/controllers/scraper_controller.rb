require 'json'
require 'pp'

class ScraperController < ApplicationController
  def scrape
    %x(bin/rails runner  ./scrapeAndStore/ManageLocalDB.rb update)
    puts "hi"
    render:index
  end
  def load
    down()
    loader()
    render:index
  end
  def index
    
  end
  private def loader
  # puts Dir.glob("#{__dir__}/result/*")
  independents=["2193","4193","4998","4998H","4999","4999H","6193","6999","8998","8999"]

  # all the json files will be process in this part each iteration we process one course
  # if anyone want to change the database  , u can modify the code here
  checker=File.join("**","scrapeAndStore","result","*.json")
  file_list=Dir.glob(checker)
  file_list.sort!
  file_list.each do |path|
      #do not include the independents
      puts path
      # if independents.include? path.split("/")[-1].split(".")[0]
      #     next
      # end
      json=File.read(path)
      subs = JSON.parse(json)
      # parse lec and lab relationship
      finding_lab=''
      subs.each do |sub|
          sub["auto_enrolls"]=[]
          if sub['components']=='Laboratory Required, Lecture Required'
              current_subject_id=sub['subject_number']
              # type=sub['outer_info'][1].split("-")[1]
              if sub['outer_info'][1].include? "LEC"
                  finding_lab=sub
                  sub["auto_enrolls"]=[]
              else
                  finding_lab["auto_enrolls"].append(current_subject_id)
              end
          end
      end
      puts "hi"
      subs.each do |sub|
          days=text=JSON.generate(sub["date_times"])
          temp_elw="#{sub["enroll_total"]}/#{sub["class_cap"]}/#{sub["wait_list_total"]}"
          teachers=sub["date_times"][0][2]
          Subject.create(course_id:sub["course_id"],
                        subject_id:sub["subject_number"],
                        autoenrolls:sub["auto_enrolls"].join(","),
                        date_time_days:days,
                        elw:temp_elw,
                        teacher:teachers)
      end
  
  end
  
end
private def down
  ActiveRecord::Base.connection.truncate("subjects")
  ActiveRecord::Base.connection.truncate("plans")
end
end
