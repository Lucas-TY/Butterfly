 /**
  * Initializes a new instance of a Card
  * @member  {DisplayCardSet} displaySet  - the deck of cards and the current hand
  * @member  {PlayerSet} currentPlayers - the list of current players
  * @member  {Array(Card)} currentSelection  - list of indices or card
  * @author Lucas Wu
  */
 class Controller {
     /**
      * Initializes a new instance of a Card
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
      * add a computer player to the game.
      *
      * @require the the player is not the game
      * @param {string} name the player's name
      * @param {number} points points that the player won or lost.
      * @returns {ComputerPlayer} the player that just added.
      * @returns {null} if the name is aready exsit.
      */
     addComputerPlayer(name, winProb) {

         return this.currentPlayers.addComputerPlayer(name, winProb);
     }
     /**
      * add a human player to the game.
      *
      * @require the the player is not the game
      * @param {string} name the name of the specific player
      * @returns {Player} the player that just added.
      * @returns {null} if the name is aready exsit.
      */
     addPlayer(name) {
         return this.currentPlayers.addPlayer(name);
     }
     /**
      * delete a player to the game.
      *
      * @require the the player is not the game
      * @param {string} name the name of the specific player
      * @returns {Player} the player that just deleted
      * @returns {null} if player is not in the game
      */
     deletePlayer(name) {
         return this.currentPlayers.deletePlayer(name);
     }
     /**
      * return a specific player's score.
      *
      * @require the the player is in the game
      * @param {string} name the name of the specific player
      * @returns {Player} that player you are looking for
      * @returns {null} if the player does not exsit.
      */
     playersSearch(name) {
         return this.currentPlayers.playersSearch(name);
     }
     /**
      * return a specific player's score.
      *
      * @param {string} name the name of the specific player
      * @returns {number} the score of one specific player
      * @returns {null} if player does not exist.
      */
     playersScoreCheck(name) {
         return this.currentPlayers.playersScoreCheck(name);
     }
     /**
      * display the highest score in this game
      *
      * @returns {number} the highest score
      */
     playersHighestScore() {
         return this.currentPlayers.playersHighestScore();
     }
     /**
      * check is the player already in the game
      * @param {string} name the name of a specific player
      * @returns {boolean} true the player is already in the game
      */
     playerExist(name) {
         return this.currentPlayers.playerExist(name);
     }
     /**
      * add the socre to a player
      *
      * @param {string} name the name of a specific player
      * @param {number} score the score to add
      * @returns {boolean} true the player is already in the game
      */
     addScore(name, score) {
         return this.currentPlayers.addScore(name, score);
     }

     /**
      * return a set that contains current players
      * @returns {Arrary(players)} the current players set
      */
     allPlayers() {
         return this.currentPlayers.playersName();
     }
     /**
      * reset all player's score.
      */
     resetAllScores() {
         this.currentPlayers.resetAllScores();
     }
     /**
      * Switch card deck to the default mode
      */
     setLevelDefault() {
         this.displaySet.deck.initializeNormalDeck();
         this.displaySet.initializeHand();
     }
     /**
      * Switch card deck to the rookie1 mode
      */
     setLevelRookie1() {
         this.displaySet.deck.initializeRookieDeck1();
         this.displaySet.initializeHand();
     }
     /**
      * Switch card deck to the rookie2 mode
      */
     setLevelRookie2() {
         this.displaySet.deck.initializeRookieDeck2();
         this.displaySet.initializeHand();
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
      * @param {Card} card the card you want to remove
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
      * @param {Card} card the card you want to remove
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
             return card.index;
         })

         if (isSet) {
             this.displaySet.dealFullHand(selectedIndex);
             this.clearSelection();
         }
         return isSet;
     }
 }