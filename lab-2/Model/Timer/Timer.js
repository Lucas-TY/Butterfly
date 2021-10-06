/**
 * Creates a timer object that displays a timer.
 * 
 * @param {string} btnTag - Element ID of the timer start button
 * @param {string} secondTag - Element ID of the seconds display element
 * @param {string} minuteTag - Element ID of the minutes display element
 */
function Timer(btnTag, secondTag, minuteTag){
	this.btn = document.getElementById(btnTag);
	this.seconds = document.getElementById(secondTag);
	this.minutes = document.getElementById(minuteTag);
	this.secondsRunning = 0;
	this.run = false;

	// count-up the time
	this.interval = setInterval(() => {
		if (this.run) {
			this.secondsRunning += 1;
			this.seconds.innerHTML = pad(this.secondsRunning % 60);
			this.minutes.innerHTML = pad(parseInt(this.secondsRunning / 60));
		}
	}, 1000);

	// when start timing, change "start" to "pause". 
	this.changeRun = function() {
		if (this.btn.value == "Start") {
			this.btn.value = "Pause";
			this.run = true;
		} else {
			this.btn.value = "Start";
			this.run = false;
		}
	}

	// reset the timer.
	this.reset = function() {
		this.btn.value = "Start";
		this.run = false;
		this.secondsRunning = 0;
		this.seconds.innerHTML = pad(this.secondsRunning % 60);
		this.minutes.innerHTML = pad(parseInt(this.secondsRunning / 60));
	}

	// when this.minutes and this.seconds are single digits respectively, add 0 in front.
	function pad(val) {
		var valueString = val + "";
		if (valueString.length < 2) {
			return "0" + valueString;
		} else {
			return valueString;
		}
	}
}
