require 'mechanize'
require 'json'

class Scrape

    def initialize
        # URL elements to scrape with
        @URL_HEAD = "https://content.osu.edu/v2/classes/search?q=cse&campus=col&p="
        @URL_FOOTER = "&term=1222&subject=cse&academic-career=ugrd"
        @page_num = 1
        #mechanize object
        @agent = Mechanize.new
        # total pages from results
        @total_pages = JSON.parse(@agent.get(generate_url).body)["data"]["totalPages"]

    end

    def scrape!(page_num)

        @page_num = page_num

        page_data = @agent.get(generate_url).body
        data = JSON.parse(page_data)

        courses = data["data"]["courses"]

        courses.each do |course| 
            # get course id and print message to console
            course_id = course["course"]["catalogNumber"]
            puts "scraping CSE #{course_id}"

            course_info = []

            sections = course["sections"]
            count = 1
            sections.each do |section|
                subject_data = {}
                outer_array = []
                meetings = section["meetings"]

                subject_data["course_id"] = course_id


                outer_array.append section["classNumber"]
                outer_array.append section["title"]
                outer_array.append get_daytime meetings
                outer_array.append get_rooms meetings
                outer_array.append get_instructors meetings
                outer_array.append section["sessionDescription"]

                subject_data["outer_info"] = outer_array


                subject_data["open_status"] = section["enrollmentStatus"]
                subject_data["subject_number"] = section["classNumber"]
                subject_data["session"] = section["sessionDescription"]
                subject_data["units_range"] = course["course"]["maxUnits"]
                subject_data["instruct_mode"] = section["instructionMode"]
                subject_data["components"] = section["primaryComponent"]
                subject_data["career"] = section["career"]
                subject_data["dates"] = "#{section["startDate"]} - #{section["endDate"]}"
                subject_data["grading"] = course["course"]["grading"]
                subject_data["location"] = section["location"]
                subject_data["campus"] = section["campus"]

                subject_data["date_times"] = get_datetime meetings

                subject_data["enroll"] = get_enroll(course["course"]["courseAttributes"])
                
                subject_data['class_cap'] = "-" # unavailable from this site
                subject_data['enroll_total'] = section["enrollmentTotal"]
                subject_data['available_seats'] = "-" # unavailable from this site
                subject_data['wait_list_cap'] = section["waitlistCapacity"]
                subject_data['wait_list_total'] = section["waitlistTotal"]

                subject_data['description'] = section["courseDescription"]
                subject_data['textbook'] = "-" # textbook data saved in attributes if it exists

                course_info.append subject_data

                # output progress to terminal
                puts "scrape subject ##{count}"
                count += 1
            end

            file_path = "#{__dir__}/result/#{course_id}.json"
            if File.exists? file_path
                puts "File already exists"
                file_path = "#{__dir__}/result/#{course_id}-1.json"
            end
            json_text = JSON.generate(course_info)
            puts "writing to file..."
            File.open(file_path, "w") { |file| file.write json_text }
        end

    end

    def get_total_pages
        @total_pages
    end

    private def generate_url
        "#{@URL_HEAD}#{@page_num}#{@URL_FOOTER}"
    end

    private def get_day(meeting)
        active_days = ""
        days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

        days.each do |day|
            if meeting[day]
                active_days += day.capitalize.slice 0, 2
            end
        end

        active_days
    end

    # create a day time object
    private def get_daytime(meetings)
        daytime = ""
        days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

        meetings.each do |meeting| 
            daytime += get_day meeting
            daytime += " #{meeting["startTime"]} - #{meeting["endTime"]}"
        end

        daytime
    end

    # get rooms for each meeting
    private def get_rooms(meetings)
        rooms = ""
        meetings.each do |meeting|
            rooms += "#{meeting["buildingDescription"]} "
        end
        rooms
    end

    private def get_meeting_instructor(meeting)
        instructors = []
        meeting["instructors"].each do |instructor|
            name = instructor["displayName"]
            if !name
                name = "TBA"
            end
            instructors.push name
        end
        instructors
    end

    # get a list of instructors
    private def get_instructors(meetings)
        instructors = []
        meetings.each do |meeting|
            instructors.concat get_meeting_instructor(meeting)
        end
        instructors.join
    end

    # get a list of the date and time information for each meeting
    private def get_datetime(meetings)
        info = []
        meetings.each do |meeting|
            meeting_info = []

            schedule = get_day meeting
            schedule += " #{meeting["startTime"]} - #{meeting["endTime"]}"
            
            meeting_info.append schedule
            meeting_info.append meeting["buildingDescription"]
            meeting_info.append get_meeting_instructor(meeting).join
            meeting_info.append "#{meeting["startDate"]} - #{meeting["endDate"]}"

            info.append meeting_info
        end
        info
    end

    # get enrollment info
    private def get_enroll(attributes)
        results = []
        attributes.each do |attrib|
            results.push attrib["description"]
        end
        results.join
    end
    
end
# empty result directory
FileUtils.rm_rf "#{__dir__}/result"
FileUtils.mkdir "#{__dir__}/result"

scraper = Scrape.new
current_page = 1

while current_page <= scraper.get_total_pages
    scraper.scrape! current_page
    current_page += 1
end