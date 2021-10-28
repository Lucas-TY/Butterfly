# Application to allow viewing and updating database from the command line
#
# @author Benjamin Mathys


# Returns the value of the input.
#
# @param menuInput [String] the input string to check
# @return [String] the command to use, return "invalid" if command was invalid
def input_check(menuInput)
    # Command to return
    command = "invalid"
    # Split the string using spaces
    splitString = menuInput.split()
    # Command is one word, update command if input is in command list
    if splitString.length == 1
        if menuInput == "list" || menuInput == "update" || menuInput == "quit"
            command = menuInput
        end
    # Command is multiple words, update command if it is in "list ####" format
    else 
        if splitString[0] == "list" && is_in_db?(splitString[1])
            command = splitString[1]
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
    courseNumbers = File.read("scrapeAndStore/classes").split
    i = 0
    # Update inDB if given course number matches an entry in the course file
    while !inDB && i < courseNumbers.length
        inDB = courseNumber == courseNumbers[i]
        i += 1
    end
    return inDB
end

# List out the commands and prompt for input
menuInput = ""
while menuInput != "quit" 
    puts "List of commands: "
    puts "list : Lists all classes and information in the database"
    puts "list \'####\' : Lists the information for that class number"
    puts "update : Update the database with new class information"
    puts "quit : Exit the application\n"
    puts "Enter a command: "
    menuInput = gets.chomp
    puts ""

    checkedInput = input_check(menuInput)

    # If checkedInput is "quit", go back to the top
    if checkedInput != "quit"
        if checkedInput == "list"
            #List out all the information for each class to the console window
        elsif checkedInput == "update"
            #Scrape and update the db
        elsif checkedInput == "invalid"
            puts "Invalid command. Please enter a valid command."
        else
            #List out all the information for a specific course number
            puts "Valid course!"
        end
    end
    puts ""
end
