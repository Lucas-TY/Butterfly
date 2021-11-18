require 'json'
require 'pp'

class Addjsons < ActiveRecord::Migration[6.1]
  def up
    create_table :subjects do |t|
      t.string :course_id
      t.string :subject_id
      t.string :open_status
      t.string :units_range
      t.string :instruct_mode
      t.string :days_times
      t.string :room
      t.string :enrld_wait
      t.string :instructor
      # t.string :autoenrolls
      t.timestamps
    end
    # puts Dir.glob("#{__dir__}/result/*")
    independents=["2193","4193","4998","4998H","4999","4999H","6193","6999","8998","8999"]

    # all the json files will be process in this part each iteration we process one course
    file_list=Dir.glob("#{__dir__}/result/*")
    file_list.sort!
    file_list.each do |path|
      #do not include the independents
      puts path
      # if independents.include? path.split("/")[-1].split(".")[0]
      #     next
      # end
      json=File.read(path)
      subs = JSON.parse(json)

      subs.each do |sub|
        #days=text=JSON.generate(sub["date_times"])
        day_time = sub["date_times"][0][0]
        classroom = sub["date_times"][0][1]
        instructors=sub["date_times"][0][2]
        temp_ew="#{sub["enroll_total"]} / #{sub["wait_list_total"]}"
        Subject.create(course_id:sub["course_id"],
                       subject_id:sub["subject_number"],
                       open_status:sub["open_status"],
                       units_range:sub["units_range"],
                       instruct_mode:sub["instruct_mode"],
                       days_times:day_time,
                       room:classroom,
                       enrld_wait:temp_ew,
                       instructor:instructors)
        # autoenrolls:sub["auto_enrolls"].join(","))
      end


    end
  end
  def down
    drop_table(:subjects)
  end
end