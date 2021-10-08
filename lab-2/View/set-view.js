// Create a controller instance to handle events
var guiController = new Controller()

/**
 * Pass the player name to the controller for input.
 * 
 * @param {String} playerName
 * 
 * @returns void
 */
function addPlayer(playerName) {
    var result = guiController.addPlayer(playerName);
    document.getElementById("playername").value = "";
    if (result == null) {
        console.log("Player \'" + playerName + "\' is already in the game!");
    } else {
        console.log("Player \'" + playerName + "\' added!");
    }
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
        }
        else if (difficultyOptions[1].checked) {
            guiController.setLevelRookie1();
        }
        else {
            guiController.setLevelRookie2();
        }

        // Hide the main menu.
        mainMenu.style.display = "none";

        let hand = guiController.getHand();
        rebuildCardTable(hand);

        // Build the table of players. One row, n/2 columns.
        let playerTable = document.getElementById("playertable");
        console.log(playerTable);   
        let selectionRow = document.createElement("tr");
        let scoreRow = document.createElement("tr");
        for (let i = 0; i < numPlayers; i++) {
            let selectionCell = document.createElement("td");
            selectionCell.setAttribute("style", "border: 1px solid black");
            let scoreCell = document.createElement("td");
            scoreCell.setAttribute("style", "border: 1px solid black");

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
        console.log("Error: Must be players in game to start!");
    }
}
/**
 * Fill in the hidden table with images of cards.
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
    let isSet = guiController.isSelectionSet();
    let selected = document.getElementsByName("playerselection");
    for (let i = 0; i < selected.length; i++) {
        if (selected[i].checked) {
            var player = guiController.currentPlayers.playersList[i].playerName;
        }
    }
    if (isSet) {
        guiController.currentPlayers.addScore(player, 3);
    } else {
        let checkboxes = document.getElementsByName("cardcheckbox");
        checkboxes.forEach(element => element.checked = false);
        guiController.clearSelection();
    }
    rebuildCardTable(guiController.getHand());
    updatePlayer(player)
}

function modifySelection(id) {
    let checkbox = document.getElementById(id);
    let hand = guiController.getHand();
    if (checkbox.checked) {
        let result = guiController.addCardToSelection(hand[checkbox.value]);
        if (!result) {
            checkbox.checked = false;
        }
    } else {
        guiController.removeCardFromSelection(hand[checkbox.value]);
    }
    console.log(guiController.currentSelection);
}