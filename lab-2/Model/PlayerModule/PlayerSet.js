/**
 * a class that represents the profile of one or more players participating in this game
 * 
 * @member {Array} playersList - Array of players
 * @member {number} numOfPlayers - number of players participating in this game
 * 
 * @author Songyuan Wu & Jing Wen
 */

class PlayerSet {
  /**
   * initialize the players list
   *
   * @returns {PlayerSet} a new instance of type Players
   */
  constructor() {
    this.playersList = [];
    this.numOfPlayers = 0;
  }

  /**
   * add a computer player to the game.
   *
   * @require the the player is not the game
   * @param {string} name the player's name
   * @param {number} winProb wining probability of computer player
   * @returns {ComputerPlayer|null} the player that just added; null if the name already exists.
   */
  addComputerPlayer(name, winProb) {
    if (this.playerExist(name)) {
      return null;
    }
    this.numOfPlayers += 1;
    var player = new ComputerPlayer(name);
    player.winProb = winProb;
    this.playersList.push(player);

    return player;
  }

  /**
   * add a human player to the game.
   *
   * @require the the player is not the game
   * @param {string} name the name of the specific player
   * @returns {Player|null} the player that just added; null if the name already exists.
   */
  addPlayer(name) {
    if (this.playerExist(name)) {
      return null;
    }
    this.numOfPlayers += 1;
    var player = new Player(name);
    this.playersList.push(player);

    return player;
  }

  /**
   * delete a player to the game.
   *
   * @require the the player is not the game
   * @param {string} name the name of the specific player
   * @returns {*|null} the player's properties that just deleted; null if the player is not in the game.
   */
  deletePlayer(name) {
    for (var element of this.playersList) {
      if (element.playerName == name) {
        this.numOfPlayers -= 1;

        var idx = this.playersList.map(x => x.playerName).indexOf(element.playerName)
        this.playersList.splice(idx, 1)
        // copy_list = this.playersList;
        // this.playersList = [];
        // for (let i = 0; i < copy_list; i++) {
        //	 if (copy_list[i] != name) {
        //		 this.playersList.push(copy_list[i]);
        //	 }
        // }
        return element;
      }
    }
    return null;
  }

  /**
   * return a specific player.
   *
   * @require the the player is in the game
   * @param {string} name the name of the specific player
   * @returns {*|null} the player's properties you are looking for; null if the player does not exist.
   */
  playersSearch(name) {
    for (var element of this.playersList) {
      if (element.playerName == name) {
        return element;
      }
    }
    return null;
  }

  /**
   * reset all player's score.
   */
  resetAllScores() {
    for (var element of this.playersList) {
      element.scoreChangeTo(0);
    }
  }

  /**
   * return a specific player's score.
   *
   * @param {string} name the name of the specific player
   * @returns {null|number|*} the score property of one specific player; null if the player does not exist.
   */
  playersScoreCheck(name) {
    for (var element of this.playersList) {
      if (element.playerName == name) {
        return element.playerScore;
      }
    }
    return null;
  }

  /**
   * display the highest score in this game
   *
   * @returns {Player} the Player that has the highest score
   */
  playersHighestScore() {
    var highestScore = this.playersList[0];
    for (var element of this.playersList) {
      if (element.playerScore > highestScore.playerScore) {
        highestScore = element;
      }
    }
    return highestScore;
  }

  /**
   * check is the player already in the game
   *
   * @param {string} name the name of a specific player
   * @returns {boolean} whether the player already exists in the game; true if the player is already in the game, false if not.
   */
  playerExist(name) {
    var result = false;
    for (var element of this.playersList) {
      console.log(element)
      if (element.playerName == name) {
        result = true;
        return result;
      }
    }
    return result;
  }

  /**
   * add the score to a player
   *
   * @param {string} name the name of a specific player
   * @param {int} score the score to add
   * @returns {boolean} whether the player already exists in the game; true if the player is already in the game.
   */
  addScore(name, score) {
    var result = false;
    for (var element of this.playersList) {
      console.log(element)
      if (element.playerName == name) {
        result = true;
        element.scoreAdd(score);
        return result;
      }
    }
    return result;
  }


  /**
   * report the names of players who are already in the game
   *
   * @returns {*} the names of players who are in the game.
   */
  playersName() {
    let players = [];
    for (var element of this.playersList) {
      players.push(element.playerName);
    }
    return players;
  }
}