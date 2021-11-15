require 'mechanize'
require 'json'

# A class that defines a scraper object. The scraper takes is intialized with a specific term
# to scrape course information from the site http://classes.osu.edu/
#
# @author Adam Lechliter and Jing Wen
class Scrape

    # Initializes a new instance of a Scrape
	#
    # @param term [Number] term id to scrape data for
	# @return [Scrape] a new instance of Scrape
    def initialize(term)
        # URL elements to scrape with
        @URL_HEAD = "https://content.osu.edu/v2/classes/search?q=cse&campus=col&p="
        @URL_FOOTER = "&term=#{term}&subject=cse&academic-career=ugrd"
        @page_num = 1
        #mechanize object
        @agent = Mechanize.new
        # total pages from results
        @total_pages = JSON.parse(@agent.get(generate_url).body)["data"]["totalPages"]

    end

    # Scrapes data for each course on the current page and generates a json file
    # for each course to store the scraped data.
	#
    # @param page_num [Number] page number to scrape data from
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

            # collect course/section information
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

            # save course information to a json file
            file_path = "#{__dir__}/result/#{course_id}.json"
            if File.exists? file_path
                puts "File already exists"
                file_index = 0
                # if the course file already exists, append a number to the end of the file name
                while File.exists? file_path
                    file_index += 1
                    file_path = "#{__dir__}/result/#{course_id}-#{file_index}.json"
                end
            else
                classes_path = "#{__dir__}/classes"
                if !(File.file? classes_path)
                    File.open(classes_path, "w"){ |file| file.write "#{course_id}\n" }
                else
                    File.open(classes_path, "a"){ |file| file.write "#{course_id}\n" }
                end
            end
            json_text = JSON.generate(course_info)
            puts "writing to file..."
            File.open(file_path, "w") { |file| file.write json_text }
        end

    end

    # Returns the total amount of pages to scrape
	#
	# @return [Number] total number of pages
    def get_total_pages
        @total_pages
    end

    # Generates the url (api call) to scrape data from
    #
    # @return [String] generated URL
    private def generate_url
        "#{@URL_HEAD}#{@page_num}#{@URL_FOOTER}"
    end

    # Generates a string of the active days for the course
	#
    # @param meeting [JSON] json object that contains the meeting information
	# @return [String] a list of the active days
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

    # Creates a day time object
    #
    # @param meeting [JSON] json object that contains the meeting information
	# @return [String] a list of the active days with their corresponding times
    private def get_daytime(meetings)
        daytime = ""
        days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

        meetings.each do |meeting| 
            daytime += get_day meeting
            daytime += " #{meeting["startTime"]} - #{meeting["endTime"]}"
        end

        daytime
    end

    # Gets the rooms for each meeting
    #
    # @param meetings [Array(JSON)] list of meetings with their information
	# @return [String] a list of rooms
    private def get_rooms(meetings)
        rooms = ""
        meetings.each do |meeting|
            rooms += "#{meeting["buildingDescription"]} "
        end
        rooms
    end

  
    # Gets a list of all the instructors for a meeting
    #
    # @param meeting [JSON] json object that contains the meeting information
	# @return [Array] a list of the instructors
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

    # get a list of instructors for multiple meetings
    #
    # @param meetings [Array(JSON)] list of meetings with their information
	# @return [String] a list of instructors
    private def get_instructors(meetings)
        instructors = []
        meetings.each do |meeting|
            instructors.concat get_meeting_instructor(meeting)
        end
        instructors.join
    end

    # Get a list of the date and time information for each meeting
    #
    # @param meetings [Array(JSON)] list of meetings with their information
	# @return [String] a list of date and time information
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

    # Get enrollment info
    #
    # @param attributes [Array(JSON)] list of attributes with their information
	# @return [String] a list of enrollment information
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
FileUtils.rm_rf "#{__dir__}/classes"

# use the command line argument for the term if provided
term = ""
if (ARGV.length < 1)
    term = 1222 # default term
else
    term = ARGV[0]
end

# scrape each available page
scraper = Scrape.new term
current_page = 1

while current_page <= scraper.get_total_pages
    scraper.scrape! current_page
    current_page += 1
end