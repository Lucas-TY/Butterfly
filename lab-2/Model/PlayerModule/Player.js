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

class Player {
    /**
     * Initializes a new instance of the new player
     * 
     * @param	{string} name - name of the player
     *
     * @returns {Player} a new instance of a Player Object
     */
    constructor(name) {
        this.playerName = name;
        this.playerScore = 0;
        this.isHuman = true;
    }

    /**
     * change the player to computer player.
     */
    change_to_computer() {
        this.isHuman = false;
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
        return this.playerScore
    }

    /**
     * update the score of the player won or lost.
     * 
     * @param {number} score - the player's new score.
     * @returns {number} the new score of the player.
     */
    scoreChangeTo(score) {
        this.playerScore = score;
        return this.playerScore;
    }

    /**
     * update the name of the player.
     * 
     * @param {string} name- the player's new name.
     * @returns {string} the new name of the player.
     */
    nameChangeTo(name) {
        this.playerName = name;
        return this.playerName;
    }
}