class Controller {
    /**
     * Initializes a new instance of a Card
     * @param  {DisplayCardSet} displaySet  - the deck of cards and the current hand
     * @param  {PlayerSet} currentPlayers - the list of current players
     * @param  {Array(Card)} currentSelection  - list of indices or cards
     * 
     * @returns {Controller} a new instance of a Controller object
     */
    constructor() {
        this.displaySet = new DisplaySet();
        this.currentPlayers = new PlayerSet();
        this.currentSelection = [];
    }
    isGameComplete() {
        return true
    }
    getHand() {
        return this.displaySet.getHand
    }
    addCardToSelection(card) {

        return this.currentSelection
    }
    removeCardFromSelection(card) {

        return this.currentSelection
    }
    clearSelection() {
        this.currentSelection = [];
    }
    addPlayer(name) {
        player.add(name)
    }
    removePlayer(name) {
        player.delete(name)
    }
    isSelectionSet() {
        return this.displaySet.isSelectionSet(currentSelection)
    }
}
a = new Controller
console.log(Controller.isGameComplete);