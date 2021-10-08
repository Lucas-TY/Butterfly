/**
 * a class represents a single player's information
 * 
 * @member {string} playerName- name of the player
 * @member {number} playerScore - score of the player
 * @member {number} winProb- wining probability of computer player
 * @member {boolean} isHuman - is human player or computer player
 * 
 * @author Songyuan Wu & Jing Wen
 */

 class ComputerPlayer {
	/**
	 * Initializes a new instance of the new player
	 *
	 * @param {string} name - name of the player
	 *
	 * @returns {ComputerPlayer} a new instance of a ComputerPlayer object
	 */
	constructor(name) {
		this.playerName= name;
		this.playerScore = 0;
		this.isHuman = false;
		this.winProb= 0.0;
	}

	/**
	 * Judge whether the computer player can win the game or not.
	 * @returns {boolean} whether the computer can win the game or not; true if it wins, false if it loses.
	 */
	canIWin() {
		var r = Math.random();
		console.log(this.playerName+ ":" + r + " vs." + this.winProb);
		if (r < this.winProb) {
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
	 scoreAdd(points) {
		this.playerScore += points;
		if (this.playerScore < 0) {
			this.playerScore = 0;
		}
		return this.playerScore;
	}

	/**
	 * update the score of the player won or lost.
	 *
	 * @param {number} score - the players's new score.
	 * @returns {number} the new score.
	 */
	 scoreChangeTo(score) {
		this.playerScore = score;
		return this.playerScore;
	}

	/**
	 * update the name of the player.
	 *
	 * @param {string} name- the players's new name.
	 * @returns {string} the new name.
	 */
	 nameChangeTo(name) {
		this.playerName= name;
		return this.playerName;
	}
}
	
