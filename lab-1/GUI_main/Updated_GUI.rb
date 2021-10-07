require 'tk'
require "../CardModule/display-card-set.rb"
require "../PlayerModule/player-set.rb"

# A GUI Version for Set Game.
# @author Songyuan Wu, Ben Mathys, Jing Wen

#display a message on the screen by a alert window
#@param text[str] message to show
def message(text)
	msgBox = Tk.messageBox(Hash['type'		=> "ok", 'icon'		=> "info",'title'	 => "Message",'message' => text])
end

#window function of tk
#create a human player
#use playerset.addplayer method
def create_human_player()
	$create_player_window=TkToplevel.new{title "CreateHuman"}.geometry("300x300")
	playerName = TkVariable.new
	status=TkVariable.new
	TkLabel.new($create_player_window){text "please input player name"}.grid('row'=>0,'column'=>0,'sticky' =>'W',"columnspan"=>2)

	input_text=TkEntry.new($create_player_window,'textvariable' => playerName).grid('row'=>1,'column'=>0,'sticky' =>'EW')

	show_text=TkLabel.new($create_player_window,'textvariable' => status).grid('row'=>2,'column'=>0,'sticky' =>'W',"columnspan"=>2)
	create_player_button=TkButton.new($create_player_window){
		text 'create!'
		command proc {
			if playerName.value==''
				status.value="name cannot by empty!"
				return
			end
			if (!$players.add_player!(playerName.value).nil?)
				status.value="Success"
			else
				status.value="Already have this player!"

			end
		}
		grid('row'=>1,'column'=>1,'sticky' =>'EW')
	}
end


#window function of tk
#create a computer player
#use playerset.addplayer method
def create_computer()
	$create_computer_window=TkToplevel.new{title "CreateComputer"}.geometry("300x300")
	playerName = TkVariable.new
	status=TkVariable.new
	input_text=TkEntry.new($create_computer_window,'textvariable' => playerName).grid('row'=>1,'column'=>0,'sticky' =>'W')
	show_text=TkLabel.new($create_computer_window,'textvariable' => status).grid('row'=>0,'column'=>0,'sticky' =>'W',"columnspan"=>2)
	create_player_button=TkButton.new($create_computer_window){
		text 'create easy computer'
		command proc {
			if playerName.value==''
				status.value="name cannot by empty!"
				return
			end
			if (!$players.add_computer_player(playerName.value,0.02).nil?)
				status.value="success"
			else
				status.value="already have this player!"
			end
		}
		grid('row'=>2,'column'=>0,'sticky' =>'EW')
	}
	create_player_button=TkButton.new($create_computer_window){
		text 'create hard computer'
		command proc {
			if playerName.value==''
				status.value="name cannot by empty!"
				return
			end
			if (!$players.add_computer_player(playerName.value,0.04).nil?)
				status.value="success"
			else
				status.value="already have this player!"
			end
		}
		grid('row'=>2,'column'=>1,'sticky' =>'EW')
	}
end


#reset the game cardset and game score
#invoked by on_closing
def reset_game()
	$turn=-1
	$players.reset_all_score!
	reset_cardset($mode)
end



#func invoked when game window is closed by user
#this func invokes reset_game
def on_closing(window)
	window.destroy
	reset_game
	message("game exit!")
	$game_window=nil
end

#reset card set by name
#@param mode_name [String] the name of a specific mode
def reset_cardset(mode_name)
	if mode_name=="normal"
		$setDisplay.deck.normal!
	elsif mode_name=="rookie_shuffle1"
		$setDisplay.deck.rookie_shuffle1!
	elsif mode_name=="rookie_shuffle2"
		$setDisplay.deck.rookie_shuffle2!
	else
		return
	end
	$setDisplay.hand=[]
	$setDisplay.deal_full_hand!
end

#game main window
#create buttons and players and their proc
#handle click events
#create a task that invokes every 1s to handle computer player and timer
def start_game()
	if $setDisplay.hand_contains_set?
		$game_window=TkToplevel.new{title "Gaming"}.geometry("850x700+0+0")
		$game_window.protocol("WM_DELETE_WINDOW", proc{on_closing($game_window)})
		$playerName=""

		hint_level=0
		hint_text=TkVariable.new
		hint_text.value="need some hint?"
		hint_label=TkLabel.new($game_window,'textvariable'=> hint_text).grid('row' =>0 ,'column'=>0,"columnspan"=>2)

		hint_button=TkButton.new($game_window){
			text "hint"
			command proc{
				hint_level+=1
				puts hint_level
				if hint_level==1
					hint_text.value="Card with index #{$setDisplay.get_hint}\n is part of a set!"
				elsif hint_level>1
					hint_text.value=""
					hint_level=2
					$setDisplay.get_set.each{ |card| hint_text.value+="#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}\n"}
				end
			}
		}.grid('row' =>0 ,'column'=>2)



		#need a row_now here beacuse the card may be 15 or more in some times
		#so the rows of card display can be more than 2
		row_now=1
			# create all the buttons for card
			$card_buttons=[]
			$selected=[]
			count=0
			side='left'
			$setDisplay.hand.each do |card|
				$card_buttons.append(TkButton.new($game_window){
					image $card_pic_dict["#{card.color}_#{card.shading}_#{card.shape}_#{card.num_shapes}"]
					command proc{
						if $playerName !="" && $selected.length <3 && !$selected.include?(card.index)
							$selected.append(card.index)
							$card_buttons[card.index].background="green"
						end
						if $selected.length ==3
							#check if the set is right
							isSet = $setDisplay.is_selection_set?($setDisplay.get_card($selected[0]), $setDisplay.get_card($selected[1]), $setDisplay.get_card($selected[2]))
							if isSet
								$players.players_search($playerName).score_add!(3-hint_level)
								$setDisplay.deal_full_hand!($selected)
								puts "ok!!"
								$turn+=1
								message("player #{$playerName} wins #{3-hint_level} point in turn #{$turn}")
								$game_window.destroy()
								start_game
							else

								$turn+=1
								message("player #{$playerName} gives a wrong answer!")
								$game_window.destroy()
								start_game
							end
						end
					}
				}.grid('row'=>row_now+count/6, 'column'=>count%6) )
				count+=1
			end



		#get the row num for next row
		row_now=(row_now+(count-1)/6)+1
		$player_buttons=Hash.new


		count=0
		$players.players_list.each do |player|

			$player_buttons[player.player_name]=TkButton.new($game_window){
				text "name:#{player.player_name}\nscore:#{player.player_score}"
				command proc{
					if !player.is_human
						return
					end
					if $playerName ==""
						$playerName=player.player_name
						$player_buttons[player.player_name].background="green"
					end
				}
			}.grid('row'=>row_now, 'column'=>count)
			if !player.is_human
				$player_buttons[player.player_name].background='DodgerBlue'
			end
			count+=1
		end
		row_now+=1

		time=TkVariable.new
		time.value='10'

		TkLabel.new($game_window,'textvariable'=> time).grid('row'=>row_now, 'column'=>0)
		turn_now=$turn
		#cache answer
		ans=$setDisplay.get_set.map {|card| card.index}
		$game_window.after(2000){schedule(turn_now,ans,time)}

	else
		final_message = "Game Over";
		final_message += "\nScores:"
		$players.players_list.each do |player|
			final_message += "\n#{player.player_name} - #{player.player_score}"
		end
		message(final_message)
	end
end





#schedule func
#a schedule task for a turn that run every 1 second
#@param turn_now[int] this param is used to ensure
#schedule tasks of other turns to be closed by
#compare their turn with global $turn
#@param ans[list] the cached answer of this turn,for computer player
#@param time[int] for timer
def schedule(turn_now,ans,time)
	puts "schedule task run in turn #{turn_now} is running"
	if $turn!=turn_now
		puts "schedule task run in turn #{turn_now} killed"
		return
	end


	itime=(time.value.to_i-1)
	time.value=itime
	if time==0
		$turn+=1
		message("over time! there is no winner!")
		$game_window.destroy
		start_game
		return
	end

	$players.players_list.each do |player|
		if !player.is_human
			#can_i_win is a method for a computer player
			#to judge if it can win now by win_prob,which is decided by diffculty
			if player.can_i_win?
				$setDisplay.deal_full_hand!(ans)
				player.score_add!(3)
				$turn+=1
				message("computer player #{player.player_name} wins #{3} point in turn #{turn_now}")
				$game_window.destroy()
				start_game
				return
			end
		end
	end
	$game_window.after(2000){schedule(turn_now,ans,time)}
end


#use turn count
#this turn count also uses to make sure that no computers would win in a closed turn
#for example a task created in turn 0 will close itselt when it detect turn has changed
$turn=0
$setDisplay = CardModule::DisplayCardSet.new

# cache all the images of the cards into a dict
$card_pic_dict={}
CardModule::Card.NUM_SHAPES.each do |num|
	CardModule::Card.SHAPES.each do |shape|
		CardModule::Card.SHADING.each do |shading|
			CardModule::Card.COLOR.each do |color|
				#cache a image
				$card_pic_dict["#{color}_#{shading}_#{shape}_#{num}"]=TkPhotoImage.new("file"=>"../CardImages/#{color}_#{shading}_#{shape}_#{num}.png")
			end
		end
	end
end


$players = PlayerModule::PlayerSet.new
$playerName=""


#init window
root = TkRoot.new { title "Game Window" }.geometry("600x400+0+0")

TkLabel.new(root){text "Create:"}.grid('row'=>0,'column'=>0,'sticky' =>'EW')


create_player_button=TkButton.new(root){
	text 'create player'
	command proc { create_human_player() }
	grid('row'=>0,'column'=>1,'sticky' =>'EW')
}

create_player_button=TkButton.new(root){
	text 'create computer'
	command proc { create_computer() }
	grid('row'=>0,'column'=>2,'sticky' =>'EW')
}

# mode control block
# use this block to control
$mode=TkVariable.new
$mode.value="normal"
TkLabel.new(root,'textvariable' => $mode).grid('row'=>2,'column'=>4)
TkLabel.new(root){text " "}.grid('row'=>1,'column'=>0,'sticky' =>'EW')


TkLabel.new(root){text "mode"}.grid('row'=>2,'column'=>0,'sticky' =>'EW')

diffculitly_button0=TkButton.new(root){
	text 'normal'
	command proc {
		$mode.value="normal"
		reset_cardset($mode.value)
	}
	grid('row'=>2,'column'=>1,'sticky' =>'EW')
}
diffculitly_button2=TkButton.new(root){
	text 'rookie_shuffle1'
	command proc {
		$mode.value="rookie_shuffle1"
		reset_cardset($mode.value)
	}
	grid('row'=>2,'column'=>2,'sticky' =>'EW')
}
diffculitly_button3=TkButton.new(root){
	text 'rookie_shuffle2'
	command proc {
		$mode.value="rookie_shuffle2"
		reset_cardset($mode.value)
	}
	grid('row'=>2,'column'=>3,'sticky' =>'EW')
}

TkLabel.new(root){text " "}.grid('row'=>3,'column'=>0,'sticky' =>'EW')

#start game button
start_button=TkButton.new(root){
	text 'start'
	command proc {
		$turn=0
		puts $game_window
		if $game_window==nil
			if $players.players_name.empty?
				message("Please create a player to start game!")
			else
				start_game
			end
		else
			return
		end
	}
	grid('row'=>4,'column'=>1,'sticky' =>'EW','columnspan'=>3)
}
#make the col width be same
root.grid_columnconfig(0,"minsize"=>100)
root.grid_columnconfig(1,"minsize"=>100)
root.grid_columnconfig(2,"minsize"=>100)
root.grid_columnconfig(3,"minsize"=>100)
root.grid_columnconfig(4,"minsize"=>100)


Tk.mainloop