var btn = document.getElementById("btn");
var seconds = document.getElementById("second");
var minutes = document.getElementById("minute");
var secondsRunning = 0;
var run = false;

// count-up the time
var interval = setInterval(function () {
  if (run) {
    secondsRunning += 1;
    seconds.innerHTML = pad(secondsRunning % 60);
    minutes.innerHTML = pad(parseInt(secondsRunning / 60));
  }
}, 1000);

// when start timing, change "start" to "pause". 
function changeRun() {
  if (btn.value == "Start") {
    btn.value = "Pause";
    run = true;
  } else {
    btn.value = "Start";
    run = false;
  }
}

// reset the timer.
function reset() {
  btn.value = "Start";
  run = false;
  secondsRunning = 0;
  seconds.innerHTML = pad(secondsRunning % 60);
  minutes.innerHTML = pad(parseInt(secondsRunning / 60));
}

// when minutes and seconds are single digits respectively, add 0 in front.
function pad(val) {
  var valueString = val + "";
  if (valueString.length < 2) {
    return "0" + valueString;
  } else {
    return valueString;
  }
}
