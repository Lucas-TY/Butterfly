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
    guiController.addPlayer(playerName);
    document.getElementById("playername").value = "";
}

/**
 * Build the initial state of the game.
 * 
 * @returns void
 */
function startGame() {
    // Get div elements
    var mainMenu = document.getElementById("main_menu");
    var cards = document.getElementById("cards");
    var players = document.getElementById("players");

    // Hide the main menu and show the game itself.
    mainMenu.style.display = "none";
    cards.hidden = false;
    players.hidden = false;

    var hand = guiController.getHand();
    rebuildCardTable(hand);
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

    // Build the table
    for (let i = 0; i < 3; i++) {
        var row = document.createElement("tr");
        for (let j = 0; j < columns; j++) {
            var cell = document.createElement("td");

            // Create input element and attach attributes
            var inputEle = document.createElement("input");
            inputEle.setAttribute("type", "checkbox");
            inputEle.setAttribute("name", "cardcheckbox");
            inputEle.setAttribute("id", columns*i+j);
            cell.appendChild(inputEle);

            // Create label and attach attributes and children
            var label = document.createElement("label");
            label.setAttribute("for", columns*i+j);
            var image = document.createElement("img");
            image.setAttribute("src","CardImages/" + hand[columns*i + j].imageFile);
            label.appendChild(image);
            cell.appendChild(label);

            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}

function updatePlayers() {

}