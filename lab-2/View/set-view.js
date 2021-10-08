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
        var mainMenu = document.getElementById("main_menu");
        var game = document.getElementById("game");
        var cards = document.getElementById("cards");
        var players = document.getElementById("players");

        // Determine the difficulty based off the radio button selection.
        var difficultyOptions = document.getElementById("difficulty");
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

        var hand = guiController.getHand();
        rebuildCardTable(hand);

        // Build the table of players. One row, n/2 columns.
        var playerTable = document.getElementById("playertable");
        console.log(playerTable);   
        var selectionRow = document.createElement("tr");
        var scoreRow = document.createElement("tr");
        for (let i = 0; i < numPlayers; i++) {
            var selectionCell = document.createElement("td");
            selectionCell.setAttribute("style", "border: 1px solid black");
            var scoreCell = document.createElement("td");
            scoreCell.setAttribute("style", "border: 1px solid black");

            // Create input element and attach attributes
            var inputEle = document.createElement("input");
            inputEle.setAttribute("type", "radio");
            inputEle.setAttribute("name", "playerselection");
            inputEle.setAttribute("id", "player" + i);
            selectionCell.appendChild(inputEle);

            // Create label and attach attributes and children
            var label = document.createElement("label");
            label.setAttribute("for", "player" + i);
            var name = document.createTextNode(guiController.currentPlayers.playersList[i].playerName);
            label.appendChild(name);
            selectionCell.appendChild(label);

            var score = document.createTextNode("Score: " + guiController.currentPlayers.playersList[i].playerScore); 
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

    // Build the table, 3 rows.
    for (let i = 0; i < 3; i++) {
        var row = document.createElement("tr");
        for (let j = 0; j < columns; j++) {
            var cell = document.createElement("td");

            // Create input element and attach attributes
            var inputEle = document.createElement("input");
            inputEle.setAttribute("type", "checkbox");
            inputEle.setAttribute("name", "cardcheckbox");
            inputEle.setAttribute("id", "card" + columns * i + j);
            cell.appendChild(inputEle);

            // Create label and attach attributes and children
            var label = document.createElement("label");
            label.setAttribute("for", "card" + columns * i + j);
            var image = document.createElement("img");
            image.setAttribute("src", "CardImages/" + hand[columns * i + j].imageFile);
            label.appendChild(image);
            cell.appendChild(label);

            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}

function updatePlayers() {

}