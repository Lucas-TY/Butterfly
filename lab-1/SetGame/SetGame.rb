require_relative "../CardModule/display-card-set.rb"
require_relative "../PlayerModule/player-set.rb"

# Main console version of Set.
# @author Ben Mathys, Adam Lechliter

# Display the current hand to the user(s).
#
# @param hand [DisplayCardSet] The current hand in play
# @param numberCardsLeft [Number] The numbers of cards left in the deck
# outside of the hand
def display_hand(hand, numberCardsLeft)
	puts "Current Hand:"
	hand.each { |card| puts "#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}" }
	puts "Cards left in deck: #{numberCardsLeft}"
end

# Takes an array of 3 strings and checks if their numeric values are all different.
#
# @param indices Array[String] the array of strings to check
# @return [Boolean] true if all different, false otherwise
def all_different?(indices)
	indices[0] != indices[1] && indices[0] != indices[2] && indices[1] != indices[2]
end
	

#Get player info for each player.
puts "Welcome to Set! You may play this game with as many players that are available!"
puts "Enter Player 1's name or an empty line when all players are entered:"
players = PlayerModule::PlayerSet.new
playerIndex = 1
until (playerName = gets.chomp) == ""
	#Nil if player already exists, player object otherwise
	playerInGame = players.players_search(playerName)
	#Don't allow the same name twice and don't allow the name 'h'
	if !playerInGame && playerName != "h"
		playerIndex += 1
		players.add_player!(playerName)
	else
		if playerName != "h" then puts "Player #{playerName} is already playing!" else puts "Player name 'h' is not allowed!" end
	end
	puts "Enter Player #{playerIndex}'s name or an empty line when all players are entered:"
	
end

#Only run the game if there is actually someone playing
if players.no_of_players > 0

	#Create the display for the hand of cards.
	setDisplay = CardModule::DisplayCardSet.new

	#Run the game until there are no more possible sets in the hand. deal_full_hand! ensures there will be a set
	#in the hand if possible.
	#Used to determine which hint has been used. 0 = none, 1  = regular hint, 2 = full set.
	hintLevel = 0 
	until !setDisplay.hand_contains_set?
		display_hand(setDisplay.hand, setDisplay.amount_in_deck)
		#Different printouts based off hint level. After getting a full set as a hint, players may not request another hint until a set is entered.
		if hintLevel == 0
			puts "If you need a hint, enter 'h'. Otherwise, enter the name of the player that finds a set!"
		elsif hintLevel == 1
			puts "If you still cannot find a set, enter 'h'. Otherwise, enter the name of the player that finds a set!"
		else
			puts "Enter the name of the player to enter a set."
		end

		playerInput = gets.chomp

		if playerInput == "h" && hintLevel == 0 #No hints used and a hint is requested, one card index given.
			puts "Card with index #{setDisplay.get_hint} is part of a set!"
			hintLevel += 1
		elsif playerInput == "h" && hintLevel == 1 #One hint already used and another requested, full set given.
			puts "The cards that make up a set are:"
			setDisplay.get_set.each { |card| puts "#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}"}
			hintLevel += 1
		else    #Players entered a player name which may or may not be valid.
			#Continuously prompt the user for a valid player name for scoring purposes.
			until players.players_search(playerInput)
				puts "Invalid player name. Please enter a new player name:"
				playerInput = gets.chomp
			end
			playerToScore = players.players_search(playerInput)
			validIndices = false
			#Continuously prompt for a valid set of indices.
			until validIndices
				puts "Enter the indices of the cards in the set, each separated by a space. (E.g. 1 4 8)"
				cardIndices = gets.chomp.split()
				if cardIndices.length == 3
					#Flip validIndices to true, then flip to false if any value was a string or greater than the number of cards in the hand.
					validIndices = !validIndices
					cardIndices.each { |index| validIndices = false if (index.to_i == 0 && index != "0") || index.to_i >= setDisplay.hand.length }
					#Only check if the values are all different if validIndices is still true, as there are 3 values and they are all valid integers.
					validIndices = all_different?(cardIndices) if validIndices
				end
			end
			isSet = setDisplay.is_selection_set?(setDisplay.get_card(cardIndices[0].to_i), setDisplay.get_card(cardIndices[1].to_i), setDisplay.get_card(cardIndices[2].to_i))
			#User entered a valid set, points are given based off the current hint level. Show the scoreboard before continuting.
			if isSet 
				puts "Valid set! #{playerInput} gains #{3 - hintLevel} point(s)!"
				cardIndices.map! { |index| index.to_i }
				setDisplay.deal_full_hand!(cardIndices)
				playerToScore.score_add!(3 - hintLevel)
				playerNames = players.players_name
				puts "--SCOREBOARD--"
				for name in playerNames
					puts "#{name}: #{players.players_score_check(name)} point(s)"
				end
				hintLevel = 0
			else #Invalid set, cycle back to the top without changing the current hint state.
				puts "That was not a valid set!"
			end
		end
	end
	puts "--Final Scoreboard--"
	loopBound = players.no_of_players
	loopIndex = 1
	#Iterate until loopBound + 1 as loopIndex is used for printing ranks starting from 1.
	while loopIndex < loopBound + 1
		playerNames = players.players_name
		nameToPrint = ""
		#Get the name of the winner
		playerNames.each { |name| nameToPrint = name if players.players_score_check(name) == players.players_highest_score}
		puts "#{loopIndex}. #{nameToPrint}  Points: #{players.players_highest_score}"
		loopIndex += 1
		#Delete the winner from the list and repeat to print the entire scoreboard in order.
		players.delete_player!(nameToPrint)
	end
	
	
else
	puts "No players playing. Exiting..."
end



