// Create a controller instance to handle events
var guiController = new Controller();
// Create a Timer instance to display the time
var timer = new Timer("second", "minute");
/**
 * Pass the player name to the controller for input.
 * 
 * @param {String} playerName
 * 
 * @returns void
 */
function addPlayer(playerName) {
    let result = guiController.addPlayer(playerName);
    let statusLabel = document.getElementById("addplayerstatus");
    document.getElementById("playername").value = "";
    let str = "Player \'" + playerName + "\' added!";
    if (result == null) {
        str = "Player \'" + playerName + "\' is already in the game!";
    }
    statusLabel.innerHTML = str;
}

/**
 * Build the initial state of the game.
 * 
 * @returns void
 */
function startGame() {
    // Only start the game if there are actually players in game.
    var numPlayers = guiController.currentPlayers.numOfPlayers;
    if (numPlayers != 0) {

        // Get div elements
        let mainMenu = document.getElementById("main_menu");
        let game = document.getElementById("game");

        // Determine the difficulty based off the radio button selection.
        let difficultyOptions = document.getElementById("difficulty");
        if (difficultyOptions[0].checked) {
            guiController.setLevelDefault();
        } else if (difficultyOptions[1].checked) {
            guiController.setLevelRookie1();
        } else {
            guiController.setLevelRookie2();
        }

        // Hide the main menu.
        mainMenu.hidden = true;

        let hand = guiController.getHand();
        rebuildCardTable(hand);

        // Build the table of players. One row, n/2 columns.
        let playerTable = document.getElementById("playertable");
        let selectionRow = document.createElement("tr");
        let scoreRow = document.createElement("tr");
        for (let i = 0; i < numPlayers; i++) {
            let selectionCell = document.createElement("td");
            selectionCell.setAttribute("class", "players");
            let scoreCell = document.createElement("td");
            scoreCell.setAttribute("class", "players");

            // Create input element and attach attributes
            let inputEle = document.createElement("input");
            inputEle.setAttribute("type", "radio");
            inputEle.setAttribute("name", "playerselection");
            inputEle.setAttribute("id", "player" + i);
            selectionCell.appendChild(inputEle);

            // Create label and attach attributes and children
            let label = document.createElement("label");
            label.setAttribute("for", "player" + i);
            let name = document.createTextNode(guiController.currentPlayers.playersList[i].playerName);
            label.appendChild(name);
            selectionCell.appendChild(label);

            scoreCell.setAttribute("id", guiController.currentPlayers.playersList[i].playerName);
            let score = document.createTextNode("Score: " + guiController.currentPlayers.playersList[i].playerScore);
            scoreCell.appendChild(score);

            selectionRow.appendChild(selectionCell);
            scoreRow.appendChild(scoreCell);
        }
        playerTable.appendChild(selectionRow);
        playerTable.appendChild(scoreRow);

        //Show the game.
        game.hidden = false;

    } else {
        window.alert("Error: Must be players in game to start!");
    }
}

/**
 * Fill in the div for the card table.
 * Fill in the card table with images of cards.
 * Outer loop creates rows, inner loop fills. 
 * 3 rows, number of cards / 3 columns.
 * Cells accessed from array index (columns)*i + j
 * 
 * @param {Array[Card]} hand - The hand of cards
 * 
 * @returns void
 * 
 */
function rebuildCardTable(hand) {

    // Change number of cards left in the deck
    document.getElementById("cardsleft").innerHTML = "Cards Left in Deck: " + (guiController.displaySet.amountInDeck());

    // Bounds for table
    var handSize = hand.length;
    var columns = hand.length / 3;

    // Table in document
    var table = document.getElementById("cardtable");
    while (table.children.length > 0) {
        table.removeChild(table.firstChild)
    }

    // Build the table, 3 rows.
    for (let i = 0; i < 3; i++) {
        var row = document.createElement("tr");
        for (let j = 0; j < columns; j++) {
            var cell = document.createElement("td");
            cell.setAttribute("id", "cell" + (columns * i + j));
            cell.setAttribute("style", "");

            // Create input element and attach attributes
            var inputEle = document.createElement("input");
            inputEle.setAttribute("type", "checkbox");
            inputEle.setAttribute("name", "cardcheckbox");
            inputEle.setAttribute("id", "card" + (columns * i + j));
            inputEle.setAttribute("onchange", "modifySelection(this.id)");
            inputEle.setAttribute("value", (columns * i) + j);
            cell.appendChild(inputEle);

            // Create label and attach attributes and children
            var label = document.createElement("label");
            label.setAttribute("for", "card" + (columns * i + j));
            var image = document.createElement("img");
            image.setAttribute("src", "CardImages/" + hand[(columns * i) + j].imageFile);
            label.appendChild(image);
            cell.appendChild(label);

            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}

/**
 * 
 * @param {String} player name of the player to update
 */
function updatePlayer(player) {
    let playerToUpdate = document.getElementById(player);
    playerToUpdate.removeChild(playerToUpdate.firstChild);
    let newScore = document.createTextNode("Score: " + guiController.playersScoreCheck(player));
    playerToUpdate.appendChild(newScore);
}

/**
 * Get the selected cards and check if they make up a set.
 * If they do, credit the player that is selected.
 * 
 * @returns void
 */
function setCheck() {
    // Get the selected player and uncheck their box.
    let selected = document.getElementsByName("playerselection");
    for (let i = 0; i < selected.length; i++) {
        if (selected[i].checked) {
            var player = guiController.currentPlayers.playersList[i].playerName;
            selected[i].checked = false;
        }
    }
    // If no player was selected, reject the check.
    if (player != null) {
        // If the set entered is invalid, reject.
        if (guiController.selectionCheck()) {
            let isSet = guiController.isSelectionSet();
            let hintButton = document.getElementById("hintbutton");
            if (isSet) {
                guiController.currentPlayers.addScore(player, 3 - parseInt(hintButton.value));
            } else {
                let checkboxes = document.getElementsByName("cardcheckbox");
                checkboxes.forEach(element => element.checked = false);
                guiController.clearSelection();
                window.alert("That was not a set!");
            }
            rebuildCardTable(guiController.getHand());
            timer.reset();
            timer.changeRun();
            updatePlayer(player);

            // Update the hint button
            hintButton.value = "0";
            hintButton.innerHTML = "Hint? (0/2)";

        } else {
            window.alert("Three cards must be selected!");
        }
    } else {
        window.alert("A player must be selected!");
    }


    //If game is complete(not running), display the scoreboard and stop timer.
    if (!guiController.isGameRunning()) {
        document.getElementById("score-title").hidden = false;
        // Remove each player from the game and attach to scoreboard.
        while (guiController.currentPlayers.numOfPlayers > 0) {
            let player = guiController.playersHighestScore();
            let eleToAdd = document.createElement("li");
            eleToAdd.innerHTML = player.playerName + ", Score: " + player.playerScore;
            guiController.deletePlayer(player.playerName);
            document.getElementById("endgamescores").appendChild(eleToAdd);
        }
        timer.reset();
        document.getElementById("game-objects").hidden = true;
        document.getElementById("scoreboard").hidden = false;
    }
}

/**
 * Function to handle returning to main menu after displaying scoreboard.
 */
function returnToMainMenu() {
    document.getElementById("game").hidden = true;
    document.getElementById("cards").hidden = false;
    document.getElementById("players").hidden = false;
    document.getElementById("game-objects").hidden = false;
    document.getElementById("scoreboard").hidden = true;
    document.getElementById("score-title").hidden = true;
    document.getElementById("main_menu").hidden = false;
    document.getElementById("addplayerstatus").innerHTML = "";
    document.getElementById("playertable").innerHTML = "";
    // Clear previous scoreboard.
    var board = document.getElementById("endgamescores");
    while (board.children.length > 0) {
        board.removeChild(board.firstChild)
    }
}

/**
 * Handle adding and removing cards from the selection when a checkbox is clicked.
 * 
 * @param {String} id the id of the checkbox that was clicked
 * 
 * @returns void
 */
function modifySelection(id) {
    let checkbox = document.getElementById(id);
    let hand = guiController.getHand();
    /* If the box is checked, add it to the selection. If the selection is already
    full, immediately untoggle the box. If the box is unchecked, just remove the card
    from the selection.
    */
    if (checkbox.checked) {
        let result = guiController.addCardToSelection(hand[checkbox.value]);
        if (!result) {
            checkbox.checked = false;
        }
    } else {
        guiController.removeCardFromSelection(hand[checkbox.value]);
    }
}

/**
 * Provides a hint to the user based on the current hint level.
 * @param {String} value the level of hints given
 */
function giveHint(value) {
    let hintButton = document.getElementById("hintbutton");
    if (value == 0) {
        // Set the card at the returned index to have a red border.
        let cardId = guiController.displaySet.getHint();
        document.getElementById("cell" + cardId).setAttribute("style", "border: 2px solid red");
        hintButton.value = "1";
        hintButton.innerHTML = "Hint? (1/2)";
    } else if (value == 1) {
        let set = guiController.displaySet.getSet();
        // Set each cell that contains a card in the hint to have a red border.
        for (let i = 0; i < set.length; i++) {
            document.getElementById("cell" + set[i].index).setAttribute("style", "border: 2px solid red");
        }
        hintButton.value = "2";
        hintButton.innerHTML = "Hint? (2/2)";
    } else {
        window.alert("You have used all of your hints!");
    }
}
/**
 * Start the timer
 */
function timerStart() {
    timer.changeRun();
}
/**
 * Reset the timer
 */
function timerReset() {
    timer.reset();
}
/**
 * Function for set Check button to debug
 */
function skip() {
    let checkboxes = document.getElementsByName("cardcheckbox");
    checkboxes.forEach(element => element.checked = false);
    guiController.clearSelection();
    guiController.skip();
    rebuildCardTable(guiController.getHand());
}