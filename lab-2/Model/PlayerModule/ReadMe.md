README - Player Module

# Player Class

---

- Create a new player's property  

  - Initialize the information of the new player: new Player(name)
  - The initial score of the new player is default by 0.
    + Example:
      + playerInstance = new Player("Jack")


- Update the properties of the player

  + Properties: player_name, player_score
  
  + Add the points that the player won or lost
    + If the score is reduced to a negative number, set the score to 0.
      + Example:
        + playerInstance.score_add(100) --> 100
  
  + Update the score of the player to a new score
    + Example:
      + playerInstance.score_change_to(200) --> 200
  
  + Update the name of the player to a new name
      + Example:
          + playerInstance.name_change_to("Jim") --> "Jim"

# ComputerPlayer Class

---

- Create a computer player's property  

  - Initialize the information of the new player: new Player(name)
  - The initial score of the new player is default by 0.
  - The initial win probability is default by 0.0
    + Example:
      + playerInstance = new ComputerPlayer("pc_player1")

- Update the properties of the computer player

  + Properties: player_name, player_score
  
  + Add the points that the computer player won or lost
    + If the score is reduced to a negative number, set the score to 0.
      + Example:
        + playerInstance.score_add(100) --> 100
  + Update the score of the player to a new score
    + Example:
      + playerInstance.score_change_to(200) --> 200
  
  + Update the name of the player to a new name
      + Example:
          + playerInstance.name_change_to("pc_player2") --> "pc_player2"    
          
# PlayerSet Class

---

- Initialize the player list which will contain the properties of one or more participating players.
  + Instance variables: 
    + player_list: an array contains the properties of one or more players.
    + no_of_players: the number of players participating in the game at the same round.

  + Example:
    + playerListInstance = new PlayerSet()


- Public methods:

- add_computer_player(name, win_prob)
  + Purpose: add a computer player to the game.
- add_player(name) 
  + Purpose: add a new player in the game

- delete_player(name)
  + Purpose: delete a player who is in the game

- players_search(name)
  + Purpose: report properties of the player who is in the game.
 
- reset_all_score()
  + Purpose: reset all players' score to 0.

- players_score_check(name)
  + Purpose: report the score of the specific player.

- players_highest_score()
  + Purpose: get the highest score in the game and report it.

- player_exist(name)
  + Purpose: check whether the specific player is already in the game.

- players_name()
  + Purpose: report names of all participating players. 
