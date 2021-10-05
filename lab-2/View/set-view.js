window.onload = function () {
    // Create variables for each button.
    var normalShuffle = document.getElementById("normal");
    var rookieShuffleOne = document.getElementById("rookie1");
    var rookieShuffleTwo = document.getElementById("rookie2");
    var addPlayerButton = document.getElementById("addplayer");
    var startGameButton = document.getElementById("startgame");

    // Add event listeners to each button.
    normalShuffle.addEventListener("click", function l() { window.alert("NEED NORMAL SHUFFLE") }/*setDifficulty("normal")*/, false);
    rookieShuffleOne.addEventListener("click",function t() { window.alert("NEED ROOKIE SHUFFLE") } /*setDifficulty("rookie1")*/, false);
    rookieShuffleTwo.addEventListener("click",function r() { window.alert("NEED ROOKIE SHUFFLE 2") } /*setDifficulty("rookie2")*/, false);
    addPlayerButton.addEventListener("click", function v() { window.alert("NEED TO ADD PLAYER") }/*add_player(document.getElementById("playername").value)*/, false);
    startGameButton.addEventListener("click", function s() { window.alert("NEED TO START GAME") }/*function to start game*/, false);
}