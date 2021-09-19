README - Card Module

#Card Class

- Get an array of the possible card properties (constants that are independent from an instance)
	+ Constants (Class Variables): NUM_SHAPES, SHAPES, SHADING, COLOR
	+ example: 
		- Get the possible shapes: Card.SHAPES --> [:diamond, :squiggle, :oval]

- Create a card
	+ Initialize a card: Card.new(<num_shapes>, <shape>, <shadding>, <color>)
		- examples: 
			+ cardInstance = Card.new<1, :oval, :solid, :green>
			+ cardInstance = Card.new<Card.NUM_SHAPES[0], Card.SHAPES[2], Card.SHADING[0], Card.COLOR[1]>

- Access a card's properties
	+ Properties: num_shapes, shape, shadding, color
	+ Access using an instance of a card
		- example:
			+ cardInstance.shape --> :oval


#Card Set Class

- Initialize a deck
+ Create an instance of Set
	- example: 
		+ setInstance = Set.new

- Instance variables:
+ deck (read only)
	- An array of cards intialized with 81 unique and randomly sorted cards when Set instance is created.
		+ will appear to have 69 cards in the beginning since 12 cards were removed and added to the hand.

- Public methods:
+ deal_card!
	- Purpose: removes a card from the deck and returns that card.

+ remaining_amount
	- Purpose: returns the amount of cards left in the deck

+ is_empty?
	- Purpose: returns whether the deck is empty or not



Display Class

- Initialize a hand
+ Create an instance of DisplayCardSet
	- example: 
		+ displayCardSetInstance = DisplayCardSet.new

- Instance variables:
+ hand (read only)
	- An array of cards, initialized to 12 cards from the deck.

- Public methods:
+ deal_full_hand!
	- Purpose: update the hand with new cards from the deck
	- Optional paramter: indices
		+ an array of indices to replace cards selected by the player
			- example: player took the cards indexed in the hand at 0, 2, and 5
				+ setInstance.deal_hand!([0, 2, 5]);
				+ replaces the taken cards with new cards from the deck
		+ if no array of indices is given, deal_hand! will populate the hand with 12 new cards from the deck
			- Uses: 
				+ initialize a deck with 12 cards (detects automatically when the hand is empty)
				+ add 3 cards to a hand when the hand has 12 cards and no set is possible
		+ it will also continue to add three cards to the deck until a set is possible in the hand.
+ hand_contains_set?
	-  Purpose: checks to see if the current hand contains a possible set
		+ This is used to check if a set is possible (returns true if a set is possible)
+ is_selection_set?
	- Purpose: given 3 cards as arguments, it checks if the cards are a set
		+ returns true if the cards do make up a set
+ amount_in_deck
	- Purpose: return the amout of cards left in the deck.