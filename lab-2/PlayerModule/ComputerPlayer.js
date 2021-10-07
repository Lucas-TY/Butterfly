/**
 * a class represents a single player's information
 * 
 * @member {string} player_name - name of the player
 * @member {number} player_score - score of the player
 * @member {number} win_prob - wining probability of computer player
 * @member {boolean} is_human - is human player or computer player
 * 
 * @author Songyuan Wu & Jing Wen
 */

 class ComputerPlayer {
    /**
     * Initializes a new instance of the new player
     *
     * @param  {string} name - name of the player
     *
     *
     * @returns {Player} a new instance of a player
     */
    constructor(name) {
      this.player_name = name;
      this.player_score = 0;
      this.is_human = false;
      this.win_prob = 0.0;
    }
    static can_i_win() {
      r = Math.random();
      console.log(this.player_name + ":" + r + " vs." + this.win_prob);
      if (r < this.win_prob) {
        return true;
      } else {
        return false;
      }
    }
  
    /**
     * update the score of the player won or lost.
     *
     * @param {number} points - points that the player won or lost.
     * @returns {number} the updated score.
     */
    static score_add(points) {
      this.player_score += points;
      if (this.player_score < 0) {
        this.player_score = 0;
      }
      return this.player_score;
    }
  
    /**
     * update the score of the player won or lost.
     *
     * @param {number} score - the players's new score.
     * @returns {number} the new score.
     */
    static score_change_to(score) {
      this.player_score = score;
      return this.player_score;
    }
  
    /**
     * update the name of the player.
     *
     * @param {string} name- the players's new name.
     * @returns {string} the new name.
     */
    static name_change_to(name) {
      this.player_name = name;
      return this.player_name;
    }
  }
  
