require 'json'

# Application to allow viewing and updating database from the command line
#
# @author Benjamin Mathys

# Print out all the information for the course
#
# @param courseNumber [Number] the number of the course to print info for
# @return void
def course_info(courseNumber)
    actualCourse = courseNumber.to_s
    index = 1
    puts "Printing info for CSE-#{courseNumber.to_s}...\n"
    while (File.exist?("#{__dir__}/result/#{actualCourse}.json"))
        json = JSON.parse(File.read("#{__dir__}/result/#{actualCourse}.json"))
        json.each do |course|
            course.each do |key,value|
                if key == "course_id"
                    puts "\n" # Separate classes by newlines
                end
                # Ignore this entry, is more of a "summary"
                if key != "outer_info" 
                    puts "#{key} : #{value}"
                end
            end
        end
        actualCourse = actualCourse.concat("-#{index}")
        index += 1
    end
    puts "\nEnter anything to continue..."
    gets
end

# Returns the value of the input.
#
# @param menuInput [String] the input string to check
# @return [String] the command to use, return "invalid" if command was invalid
def input_check(menuInput, validTermCodes)
    # Command to return
    command = "invalid"
    # Split the string using spaces
    splitString = menuInput.split()
    # Command is one word, update command should input be in command list
    if splitString.length == 1
        if menuInput == "list" || menuInput == "update" || menuInput == "quit"
            command = menuInput
        end
    # Command is multiple words, update command should it be in "list ####" or "update ####" format
    else 
        if splitString[0] == "list" && is_in_db?(splitString[1]) # Check list command
            command = splitString[1]
        elsif splitString[0] == "update" && validTermCodes.index(splitString[1]) # Check update command
            command = menuInput
        end
    end
    return command
end

# Finds whether or not the given course number is in the database.
# 
# @param courseNumber [Number] the course number to check
# @return [Boolean] true if in DB, false otherwise
def is_in_db?(courseNumber)
    inDB = false
    courseNumbers = File.read("#{__dir__}/classes").split
    i = 0
    # Update inDB if given course number matches an entry in the course file
    while !inDB && i < courseNumbers.length
        inDB = courseNumber == courseNumbers[i]
        i += 1
    end
    return inDB
end
# Runs the given command from command line or from menu
#
# @param command [String] the command to run
# @return void
def run_command(command)
    commands = command.split
    if commands[0] == "list" && commands.length == 1
        courseNumbers = File.read("#{__dir__}/classes").split
        courseNumbers.each do |course|
            course_info(course)
        end
    elsif commands[0] == "update"
        #Scrape and update the db
        #Fork the re-scraping so that the main program doesn't quit out.
        pid = Process.fork do
            if commands.length == 1
                exec("ruby scrape.rb")
            else
                exec("ruby scrape.rb #{commands[1]}")
            end
        end
        #Wait for child to exit so that menu input comes after scraping
        Process.waitpid(pid)
    elsif commands[0] == "invalid"
        puts "Invalid command. Please enter a valid command."
    else
        #List out all the information for a specific course number
        course_info(command)
    end
end

# List out the commands and prompt for input
menuInput = ""
validTermCodes = ["1214", "1218", "1222"]
if ARGV.length == 0 # Program was started without command line args
    while menuInput != "quit" 
        puts "List of commands: "
        puts "list : Lists all classes and information in the database"
        puts "list \'####\' : Lists the information for that class number"
        puts "update : Update the database with latest term class information"
        puts "update \'xxxx\' : Update the database with specific term class info"
        puts "quit : Exit the application\n"
        puts "Enter a command: "
        menuInput = gets.chomp
        puts ""
        checkedInput = input_check(menuInput,validTermCodes)

        # If checkedInput is "quit", go back to the top
        if checkedInput != "quit"
            run_command(checkedInput)
        end
        puts ""
    end
else # Command line argument entered, use that and exit after.
<<<<<<< HEAD
    checkedInput = input_check(ARGV[0], validTermCodes)
=======
    checkedInput = input_check(ARGV[0],validTermCodes)
>>>>>>> origin/main
    # Clear args so that gets call will not try to read from a file
    # that does not exist.
    ARGV.clear 
    if checkedInput != "quit"
        run_command(checkedInput)
    end
end
