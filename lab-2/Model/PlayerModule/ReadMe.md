README - Player Module

# Player Class

---

- Create a new player's property  

  - Initialize the information of the new player: new Player(name)
  - The initial score of the new player is default by 0.
    + Example:
      + playerInstance = new Player("Jack")


- Update the properties of the player

  + Properties: playerName, playerScore
  
  + Add the points that the player won or lost
    + If the score is reduced to a negative number, set the score to 0.
      + Example:
        + playerInstance.scoreAdd(100) --> 100
  
  + Update the score of the player to a new score
    + Example:
      + playerInstance.scoreChangeTo(200) --> 200
  
  + Update the name of the player to a new name
      + Example:
          + playerInstance.nameChangeTo("Jim") --> "Jim"

# ComputerPlayer Class

---

- Create a computer player's property  

  - Initialize the information of the new player: new Player(name)
  - The initial score of the new player is default by 0.
  - The initial win probability is default by 0.0
    + Example:
      + playerInstance = new ComputerPlayer("pc_player1")

- Update the properties of the computer player

  + Properties: playerName, playerScore
  
  + Add the points that the computer player won or lost
    + If the score is reduced to a negative number, set the score to 0.
      + Example:
        + playerInstance.scoreAdd(100) --> 100
  + Update the score of the player to a new score
    + Example:
      + playerInstance.scoreChangeTo(200) --> 200
  
  + Update the name of the player to a new name
      + Example:
          + playerInstance.nameChangeTo("pc_player2") --> "pc_player2"    
          
# PlayerSet Class

---

- Initialize the player list which will contain the properties of one or more participating players.
  + Instance variables: 
    + player_list: an array contains the properties of one or more players.
    + numOfPlayers: the number of players participating in the game at the same round.

  + Example:
    + playerListInstance = new PlayerSet()


- Public methods:

- addComputerPlayer(name, winProb)
  + Purpose: add a computer player to the game.
- addPlayer(name) 
  + Purpose: add a new player to the game.

- deletePlayer(name)
  + Purpose: delete a player who is in the game.

- playersSearch(name)
  + Purpose: report properties of the player who is in the game.
 
- resetAllScores()
  + Purpose: reset all players' score to 0.

- playersScoreCheck(name)
  + Purpose: report the score of the specific player.

- playersHighestScore()
  + Purpose: get the highest score in the game and report it.

- playerExist(name)
  + Purpose: check whether the specific player is already in the game.

- addScore(name, score)
  + Purpose: add the score to a specific player who is already in the game.

- playersName()
  + Purpose: report names of all participating players. 
