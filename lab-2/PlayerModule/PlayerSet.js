/**
 * a class that represents the profile of one or more players participating in this game
 * 
 * @member {Array} players_list - Array of players
 * @member {number} no_of_players - number of players participating in this game
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
      this.players_list = [];
      this.no_of_players = 0;
    }
  
    /**
     * add a computer player to the game.
     *
     * @require the the player is not the game
     * @param {number} points points that the player won or lost.
     * @returns {ComputerPlayer} the player that just added.
     * @returns {null} if the name is aready exsit.
     */
    static add_computer_player(name, win_prob) {
      if (player_exist(name)) {
        return null;
      }
      this.no_of_players += 1;
      var player = new ComputerPlayer(name);
      player.win_prob = win_prob;
      this.players_list.push(player);
  
      return player;
    }
  
    /**
     * add a human player to the game.
     *
     * @require the the player is not the game
     * @param {string} name the name of the specific player
     * @returns {Player} the player that just added.
     * @returns {null} if the name is aready exsit.
     */
    static add_player(name) {
      if (player_exist(name)) {
        return null;
      }
      this.no_of_players += 1;
      var player = new Player(name);
      this.players_list.push(player);
  
      return player;
    }
  
    /**
     * delete a player to the game.
     *
     * @require the the player is not the game
     * @param {string} name the name of the specific player
     * @returns {Player} the player that just deleted
     * @returns {null} if player is not in the game
     */
    static delete_player(name) {
      for (var element in this.players_list) {
        if (element.player_name == name) {
          this.no_of_players -= 1;
          copy_list = this.players_list;
          this.players_list = [];
          for (let i = 0; i < copy_list; i++) {
            if (copy_list[i] != name) {
              this.players_list.push(copy_list[i]);
            }
          }
          return element;
        }
      }
      return null;
    }
  
    /**
     * return a specific player's score.
     *
     * @require the the player is in the game
     * @param {string} name the name of the specific player
     * @returns {Player} that player you are looking for
     * @returns {null} if the player does not exsit.
     */
    static players_search(name) {
      for (var element in this.players_list) {
        if (element.player_name == name) {
          return element;
        }
      }
      return null;
    }
  
    /**
     * reset all player's score.
     */
    static reset_all_score() {
      for (var element in this.players_list) {
        element.score_change_to(0);
      }
    }
  
    /**
     * return a specific player's score.
     *
     * @param {string} name the name of the specific player
     * @returns {number} the score of one specific player
     * @returns {null} if player does not exist.
     */
    static players_score_check(name) {
      for (var element in this.players_list) {
        if (element.player_name == name) {
          return element.player_score;
        }
      }
      return null;
    }
  
    /**
     * display the highest score in this game
     *
     * @returns {number} the highest score
     */
    static players_highest_score() {
      highest_score = 0;
      for (var element in this.players_list) {
        if (element.player_score > highest_score) {
          highest_score = element.player_score;
        }
      }
      return highest_score;
    }
  
    /**
     * check is the player already in the game
     *
     * @param {string} name the name of a specific player
     * @returns {boolean} true the player is already in the game
     */
    static player_exist(name) {
      result = false;
      for (var element in this.players_list) {
        if (element.player_score > name) {
          resutl = true;
          return result;
        }
      }
      return result;
    }
  
    /**
     * check is the player already in the game
     *
     * @param {string} name the name of a specific player
     * @returns {boolean} true the player is already in the game
     */
    static players_name() {
      players = [];
      for (var element in this.players_list) {
        players.concat(element.player_name);
      }
      return players;
    }
  }
  
