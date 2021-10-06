README - Card Module

# Card Class

- A class that represents a single card in the game set.


- Create a card 
  + Initialize a new instance of a card object: new Card(numShapes, shape, shading, color)
    - examples:
      + cardInstance = new Card(1, "diamond", "solid", "red")


- Access the card's properties
    + Properties: num_shapes, shape, shading, color
    + Access using an instance of a card
        - example:
            + cardInstance.getNumShapeTypes --> 1


# Card Set Class

- A class that represents a deck of cards in the game of Set.

+ Initialize a deck (an array of cards) of 81 unique cards the deck by applying the normal shuffle.
  - There will appear to have 69 cards in the beginning since 12 cards were removed and added to the hand.

#### Public Methods:

+ deal_card()
  + Purpose: removes a card from the deck and returns that card. Return null if the deck is empty.

   
+ initializeNormalDeck()
  + Purpose: initializes the deck with 81 cards and then shuffles every card in the deck.


+ initializeRookieDeck1()
  + Purpose: initializes the deck with 81 cards, applying to shuffle every shading type and color.


+ initializeRookieDeck2()
  + Purpose: initializes the deck with 81 cards, applying to shuffle every shading type, color, and shape.

  
+ getRemainAmount()
  + Purpose: reports the remaining amount of the cards in the deck.  


+ isEmpty()
  + Purpose: reports whether the deck is empty or not.  


+ shuffleArray(array)
  + Purpose: randomly shuffle the order of the array.

# DisplaySet Constructor

- A constructor that creates an object that would manage a deck of cards and deal cards to the hand.

- Can also check if the hand has a possible set and check if a given list of cards create a set.

#### Public Methods:

- this.dealFullHand = function(indices = [])
  + Purpose: Deals cards into the hand from the deck.
    + If given an array of indices, it will replace the cards at the given indices with cards from the deck.
    + If the deck is empty, it will remove the cards at those indices from the hands and shift the remaining cards in the deck.


- this.getCard = function(index)
  + Purpose: retrieves a card from the hand given an index, leaving the card in the hand.


- this.handContainsSet = function()
  + Purpose: checks whether the hand contains a possible set or not.


- this.getHint = function()
  + Purpose: gives the index of a card that is a part of a possible set.
  + The index is returned -1 if there is no card that belongs to a set.


- this.getSet = function()
  + Purpose: get an array of 3 cards in the hand that can make up a set.
  + The array would be empty if there is not set in the hand.


- this.isSelectionSet = function(card1, card2, card3)
  + Purpose: checks whether the given cards form a set or not.


- this.amountInDeck = function()
  + Purpose: reports the amount of cards left in the deck.


- this.dealHand = function(indices = [])
  + Purpose: deals cards into the hand from the deck.
    + If given an array of indices, it will replace the cards at the given indices with cards from the deck. 
    +  If the deck is empty, it will remove the cards at those indices from the hand and shift the remaining cards in the hand.


- this.initializeHand = function()
  + Purpose: initializes the this.hand array with at least 12 cards.
    + The array will add 3 cards until a set is possible in the hand.


#### Private Methods

- set_condition(feature1, feature2, feature3)
  + Purpose: checks if the given features either all three match or are all three unique from each other.
  + The three features need to be of the same card property.
  + Returns true if all three features are the same or completely different.


- number_condition(card1, card2, card3)
  + Purpose: checks if the given cards meet the set condition for the number of shapes on each card.
  + Returns true if all three cards meet the set condition for number of shapes.


- shape_condition(card1, card2, card3)
  + Purpose: checks if the given cards meet the set condition for the type of shapes on each card.
  + Returns true if all three cards meet the set condition for the type of shapes.

- shading_condition(card1, card2, card3)
  + Purpose: checks if the given cards meet the set condition for the types of shading on each card.
  + Returns true if all three cards meet the set condition for types of shading.


- color_condition(card1, card2, card3)
  + Purpose: checks if the given cards meet the set condition for the color of shapes on each card.
  + Returns true if all three cards meet the set condition for the color of shapes.


- is_set(card1, card2, card3)
  + Purpose: Checks if the given cards meet the set condition for all 4 set conditions.
  + Returns true if all three cards meet all of the set conditions.


- cards_contain_set(cards)
  + Purpose: find the three cards that make up a set.
  + Returns the index of card that a part of of set. Returns an empty array if none are found.


