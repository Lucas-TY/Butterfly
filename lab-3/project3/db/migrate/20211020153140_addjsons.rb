require 'json'
require 'pp'

class Addjsons < ActiveRecord::Migration[6.1]
  def up
    create_table :subjects do |t|
        t.string :course_id
        t.string :subject_id
        t.string :autoenrolls
        t.string :date_time_days
        t.string :elw
        t.string :teacher
        t.timestamps
    end
    # puts Dir.glob("#{__dir__}/result/*")
    independents=["2193","4193","4998","4998H","4999","4999H","6193","6999","8998","8999"]

    # all the json files will be process in this part each iteration we process one course
    # if anyone want to change the database  , u can modify the code here
    Dir.glob("#{__dir__}/result/*").each do |path|
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
  def down
    drop_table(:subjects)
  end
end
