/**
 * Creates a timer object that displays a timer.
 * 
 * @param {string} secondTag - Element ID of the seconds display element
 * @param {string} minuteTag - Element ID of the minutes display element
 *
 * @author Jing Wen & Adam Lechliter & Lucas Wu
 */
function Timer(secondTag, minuteTag, intervalFunc) {
	this.seconds = document.getElementById(secondTag);
	this.minutes = document.getElementById(minuteTag);
	this.secondsRunning = 0;
	this.secondsLeft = 75;
	this.run = false;
	this.intervalFunc = intervalFunc;

	/**
	 * Count-up the time.
	 * Calculate the minute and the second by the secondsRunning.
	 * Update displayed cards if no time left
	 *
	 */
	this.interval = setInterval(() => {
		if (this.secondsLeft == (this.secondsRunning - 1)) {
			this.secondsRunning = 0;
			let checkboxes = document.getElementsByName("cardcheckbox");
			checkboxes.forEach(element => element.checked = false);
			guiController.clearSelection();
			guiController.skip();
			
			this.intervalFunc();
		}

		if (this.run) {
			this.seconds.innerHTML = pad((this.secondsLeft - this.secondsRunning) % 60);
			this.minutes.innerHTML = pad(parseInt((this.secondsLeft - this.secondsRunning) / 60));
			this.secondsRunning += 1;
		}

	}, 1000);

	/**
	 * When Game started, timer start
	 */
	this.changeRun = function () {
		let numPlayers = guiController.currentPlayers.numOfPlayers;
		if (numPlayers != 0) {
			this.run = true;
		} else {
			this.run = false;
		}
	}

	/**
	 * Reset the timer.
	 */
	this.reset = function () {
		this.secondsRunning = 0;
		this.run = false;
		this.seconds.innerHTML = pad((this.secondsLeft - this.secondsRunning) % 60);
		this.minutes.innerHTML = pad(parseInt((this.secondsLeft - this.secondsRunning) / 60));
	}

	/**
	 * when this.minutes and this.seconds are single digits respectively, add 0 in front.
	 * @param val the value of seconds or minutes needs to be displayed.
	 * @returns {string} the string value after modifying.
	 */
	function pad(val) {
		var valueString = val + "";
		if (valueString.length < 2) {
			return "0" + valueString;
		} else {
			return valueString;
		}
	}
}