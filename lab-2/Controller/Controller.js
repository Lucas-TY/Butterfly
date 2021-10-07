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
        this.displaySet = new DisplayCardSet();
        this.displaySet.initializeHand();
        this.currentPlayers = new PlayerSet();
        this.currentSelection = [];
    }
    /**
     * Determine if the game has completed based on the hand
     * @returns {boolean} true if it contains a set
     */
    isGameComplete() {
        return this.displaySet.handContainsSet();
    }
    /**
     * return the current hand 
     * @returns {Array(Card)} the current hand
     */
    getHand() {
        return this.displaySet.hand;
    }
    /**
     * Given a card, add the card to the list of selected cards.
     * @returns {boolean} Return false if the card cannot be added to the selection.
     * @returns {Array(Card)}Return the current selection if the card has been added into selection
     */
    addCardToSelection(card) {
        if (this.currentSelection.length < 3 && !(this.currentSelection.includes(card, 0))) {
            this.currentSelection.push(card);
            return this.currentSelection
        }
        return false;

    }
    /**
     * Given a card, remove that card from the list of selected cards (do nothing if that card wasn't selected).
     * @returns {boolean} Return false if cannot find that card in the selection
     * @returns {Card}Return the deleted card if the card has removed from selection
     */
    removeCardFromSelection(card) {
        if (this.currentSelection.includes(card, 0)) {
            this.currentSelection = this.currentSelection.filter(function (item, index, arr) {
                if (item != card) {
                    return item;
                }

            });
            return card;
        }
        return false;
    }
    /**
     * Remove all selected cards from the list of selected cards
     */
    clearSelection() {
        this.currentSelection = [];
    }
    /**Given a player name, add that player to the list of current players
     * 
     * @param {*} name 
     */
    addPlayer(name) {
        this.currentPlayers.add_player(name);
    }
    /**Given a player name, remove that player from the list
     * 
     * @param {*} name 
     */
    removePlayer(name) {
        this.currentPlayers.delete_player(name);
    }
    /** Determine if the selected cards create a set. 
     * If they do, deal a new hand (replace those cards with deal_full_hand(card indices) and clear selection 
     * 
     * @returns {boolean} ture if the selected cards create a set
     */
    isSelectionSet() {
        var card1 = this.currentSelection[0];
        var card2 = this.currentSelection[1];
        var card3 = this.currentSelection[2];
        let isSet = this.displaySet.isSelectionSet(card1, card2, card3);
        let selectedIndex = this.currentSelection.map(function index(card) {
            return card.index + 1;
        })

        if (isSet) {
            this.displaySet.dealFullHand(selectedIndex);
            this.clearSelection();
        }
        return isSet;
    }
}