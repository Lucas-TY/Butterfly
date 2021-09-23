
require 'tk'
require "../CardModule/display-card-set.rb"
require "../PlayerModule/player-set.rb"


def message(text)
  msgBox = Tk.messageBox(Hash['type'    => "ok", 'icon'    => "info",'title'   => "Message",'message' => text])
end

#create name of a new human user
#players:playerSet
#return str
def create_human_player()
  $create_player_window=TkToplevel.new.geometry("500x500")
  playerName = TkVariable.new
  status=TkVariable.new

  input_text=TkEntry.new($create_player_window,'textvariable' => playerName).pack

  show_text=TkLabel.new($create_player_window,'textvariable' => status).pack
  create_player_button=TkButton.new($create_player_window){
    text  'create!'
    command proc {
      if (!$players.add_player(playerName.value).nil?)
        status.value="success"
      else
        status.value="already have this player!"
      end
    }
    pack('side'=>'left', 'padx'=>10, 'pady'=>10)
  }
end

def create_computer()
  $create_computer_window=TkToplevel.new.geometry("500x500")
  playerName = TkVariable.new
  status=TkVariable.new
  input_text=TkEntry.new($create_computer_window,'textvariable' => playerName).pack
  show_text=TkLabel.new($create_computer_window,'textvariable' => status).pack
  create_player_button=TkButton.new($create_computer_window){
    text  'create easy computer'
    command proc {
      if (!$players.add_player(playerName.value).nil?)
        $players.players_search(playerName.value).change_to_computer
        $players.players_search(playerName.value).win_prob=0.05
        status.value="success"
      else
        status.value="already have this player!"
      end
    }
    pack('side'=>'left', 'padx'=>10, 'pady'=>10)
  }
  create_player_button=TkButton.new($create_computer_window){
    text  'create hard computer'
    command proc {
      if (!$players.add_player(playerName.value).nil?)
        $players.players_search(playerName.value).change_to_computer
        $players.players_search(playerName.value).win_prob=0.1
        status.value="success"
      else
        status.value="already have this player!"
      end
    }
    pack('side'=>'left', 'padx'=>10, 'pady'=>10)
  }
end



# def delay_loop()
# puts "hahaxixi"
# end
def start_game()
  $game_window=TkToplevel.new.geometry("600x1000")
  $playerName=""


  # create all the buttons for card
  $card_buttons=[]
  $selected=[]
  $setDisplay.hand.each do |card|
    $card_buttons.append(TkButton.new($game_window){
      text "#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}"
      command proc{
      }
    }.pack())
  end

  $player_buttons=Hash.new
  $players.players_list.each do |player|
    $player_buttons[player.player_name]=TkButton.new($game_window){
      text "name:#{player.player_name}\nscore:#{player.player_score}"
      command proc{
      }
    }.pack()
  end


end


#computer_player
#use after func of tk lib to start a task that generate a prob for a computer player evey x second(x can be set)
#every x second for each computer player we have a prob
#if this prob < player.win_prob then then the player wins
#this function need to run with gui
#it is useless now
def computer_play(turn_now)
  puts $turn
  puts turn_now
  if $turn!=turn_now
    return
  end
  win=false
  $players.players_list.each do |player|
    if !player.is_human
      r=rand
      puts r
      if r<player.win_prob && !win
        $setDisplay.deal_full_hand!($setDisplay.get_set.map {|card| card.index})
        if !win
          $players.players_search(player.player_name).score_add(3)
          $turn+=1
          win=true
          $game_window.withdraw()
          message("player #{player.player_name} wins #{3} point in turn #{turn_now}")
          start_game
        end
      end
    end
  end
  $game_window.after(3000){computer_play(turn_now)}
end



$turn=0



$players = PlayerModule::PlayerSet.new
$playerName=""

$setDisplay = CardModule::DisplayCardSet.new


root = TkRoot.new { title "Ex1" }.geometry("800x500")

create_player_button=TkButton.new(root){
  text  'create player'
  command proc { create_human_player() }
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)
}

create_player_button=TkButton.new(root){
  text  'create computer'
  command proc { create_computer() }
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)
}


# TkLabel.new(root) {

start_button=TkButton.new(root){
  text  'start'
  command proc { start_game }
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)
}



Tk.mainloop