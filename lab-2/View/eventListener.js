var start = document.getElementById("startgame");
var returnMain = document.getElementById("returnMain");
// Add ecvents for startgame button
start.addEventListener("click", startGame, false);
start.addEventListener("click", timerStart, false);
// Add ecvents for returnMain button
returnMain.addEventListener("click", returnToMainMenu, false);
returnMain.addEventListener("click", timerReset, false);