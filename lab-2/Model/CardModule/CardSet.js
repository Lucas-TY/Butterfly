/**
 * Randomly shuffles the order of an array.
 * 
 * @param {Array} array - an array of objects to be randomized
 */
function shuffleArray(array){
    /* 
        Source for random number algorithm: 
        https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random
    */
    for(let i = 0; i < array.length * array.length; i++){
        const randIndex = Math.floor(Math.random() * array.length);
        if(array[randIndex] == undefined){
            
        }
        // removes an item at a random index an pushes it to the beginning of the array
        array.push(array.splice(randIndex, 1)[0]);
    }
}

/**
 * A class that represents a deck of cards in the game of Set.
 * 
 * @member {Array(Card)} deck - array of current cards in the deck
 * 
 * @author Adam Lechliter
 */
class CardSet {

    /**
     * Initialize a deck of 81 cards the deck (applies a normal shuffle)
     * 
     * @return {CardSet} a new instance of type CardSet
     */
    constructor(){
        this.initializeNormalDeck();
    }

    /**
     * Deals a card from the deck, removing that card from the deck. Returns null
     * if the deck is empty. 
     * 
     * @returns {Card | null} a card removed from the deck
     */
    dealCard(){
        let card = null;
        if (this.deck.length > 0){
            card = this.deck.pop();
        }
        return card;
    }

    /**
     * Initializes the deck with 81 cards and then shuffles every card in the deck
     * 
     * @returns void
     */
    initializeNormalDeck(){
        this.deck = [];
        const tempDeck = [];
        Card.getNumShapeTypes().forEach(function(numShapes){
            Card.getShapeTypes().forEach(function(shape){
                Card.getShadingTypes().forEach(function(shading){
                    Card.getColorTypes().forEach(function(color){
                        tempDeck.push(new Card(numShapes, shape, shading, color));
                    })
                })
            })
        });
        this.deck = tempDeck;
        shuffleArray(this.deck);
    }

    /**
     * Initializes the deck with 81 cards, applying the rookie 1 shuffle
     * 
     * Rookie 1 shuffle: shuffle every shading type and color
     * 
     * @returns void
     */
    initializeRookieDeck1(){
        this.deck = [];
        const tempDeck = [];

        Card.getNumShapeTypes().forEach(function(numShapes){
            Card.getShapeTypes().forEach(function(shape){
                Card.getShadingTypes().forEach(function(shading){
                    Card.getColorTypes().forEach(function(color){
                        tempDeck.push(new Card(numShapes, shape, shading, color));
                    })
                })
                shuffleArray(tempDeck);
                this.deck = this.deck.concat(tempDeck);
                tempDeck = [];
            })
        });
        this.deck = tempDeck;
    }

    /**
     * Initializes the deck with 81 cards, applying the rookie 1 shuffle
     * 
     * Rookie 2 shuffle: shuffle every shading type, color, and shape
     * 
     * @returns void
     */
    initializeRookieDeck2(){
        this.deck = [];
        const tempDeck = [];
        Card.getNumShapeTypes().forEach(function(numShapes){
            Card.getShapeTypes().forEach(function(shape){
                Card.getShadingTypes().forEach(function(shading){
                    Card.getColorTypes().forEach(function(color){
                        tempDeck.push(new Card(numShapes, shape, shading, color));
                    })
                })
            })
            shuffleArray(tempDeck);
            this.deck = this.deck.concat(tempDeck);
            tempDeck = [];
        });
        this.deck = tempDeck;
    }

    /**
     * Reports the remaining amount of cards in the deck
     * 
     * @returns {number} the number of remaing cards in the deck
     */
    getRemainingAmount(){
        return this.deck.length;
    }

    /**
     * Reports whether the deck is empty or not
     * 
     * @returns {boolean} true if the deck is empty
     */
    isEmpty(){
        return this.deck.length == 0;
    }

}