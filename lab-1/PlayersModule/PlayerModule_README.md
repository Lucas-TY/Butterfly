README - Player Module

# Player Class

---

- Create a new player's property  

  - Initialize the information of the new player: Player.new (\<name>)\
  - The initial score of the new player is default by 0.
    + Example:
      + playerInstance = Player.new(\<"Jack">)\


- Update the properties of the player

  + Properties: player_name, player_score
  
  + Add the points that the player won or lost
    + If the score is reduced to a negative number, set the score to 0.
      + Example:
        + playerInstance.score_add(\100)\ --> 100
  
  + Update the score of the player to a new score
    + Example:
      + playerInstance.score_change_to(\200)\ --> 200
  
  + Update the name of the player to a new name
      + Example:
          + playerInstance.name_change_to(\"Jim")\ --> "Jim"
          
# PlayerSet Class

---

- Initialize the player list which will contain the properties of one or more participating players.
  + Instance variables: 
    + player_list: an array contains the properties of one or more players.
    + no_of_players: the number of players participating in the game at the same round.

  + Example:
    + playerListInstance = PlayerSet.new


- Public methods:

- add_player(\<String>\) 
  + Purpose: add a new player in the game
  + According to the player's name to add him/her in the game. If the name has already exist, do nothing.
    + Examples:
      + playerListInstance.add_player("Jack") --> [\{\"Jack"\, 0}\]

- delete_player!(\<String>\)
  + Purpose: delete a player who is in the game
  + According to the player's name to delete his/her all properties in the game. If the name is not in the game, do nothing.
    + Example:
      + playerListInstance.delete_player!(\"Jack"\) --> [ \]

- player_search(\<String>\)
  + Purpose: report properties of the player who is in the game.
  + According to the player's name to search the player and report his/her properties.
    + Example:
      + playerListInstance.players_search(\"Jim"\) --> \{\"Jim"\, 100}

- reset_all_score!
  + Purpose: reset all players' score to 0.

- players_score_check(\<String>\)
  + Purpose: report the score of the specific player.
  + According to the player's name to get the score of this player.
    + Example:
      + playerListInstance.players_score_check(\"Jim"\) --> 100

- players_highest_score
  + Purpose: get the highest score in the game and report it.

- player_exist?(\<String>\)
  + Purpose: check whether the specific player is already in the game.
    + Example:
      + playerListInstance.player_exist?(\"Jim"\) --> True

- players_name
  + Purpose: report names of all participating players. 
