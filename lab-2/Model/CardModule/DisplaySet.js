/**
 * A constructor that creates an object that manages a deck of cards (CardSet) and deals cards to a hand.
 * This class can also check if the hand has a possible set and check if a given list of cards create a set.
 * 
 * @member {Array(Card)} hand - array of the current cards in the hand
 * @member {CardSet} deck - CardSet object that represents the current deck
 * 
 * @author Adam Lechliter
 */

function DisplayCardSet() {
	const DEFAULT_HAND_SIZE = 12;
	const DEFAULT_DEAL_SIZE = 3;

	this.hand = [];
	this.deck = new CardSet();

	// public methods ----------------------------------------------------

	/** 
	 * Deals cards into the hand from the deck. Initially deals [this.this.DEFAULT_HAND_SIZE] cards
	 * into the deck, and then adds [this.this.DEFAULT_DEAL_SIZE] until the hand contains a set. If
	 * given an array of indices [indices], it will replace the cards at the given indices
	 * with cards from the deck. If the deck is empty, it will remove the cards at those 
	 * indices from the hand and shift the remaining cards in the deck.
	 *
	 * @require indices to either be left out or contain valid indices for the hand array
	 * @param {null | Array(Number)} indices - list of indices of cards to be replaced from the hand.
	 * @return {Array(Card)} current array of cards in the hand
	 */
	this.dealFullHand = function (indices = []) {
		this.dealHand(indices);

		while (!this.handContainsSet() && !this.deck.isEmpty()) {
			this.dealHand();
		}

		return this.hand;
	}

	/**
	 * Retrieves a card from the hand given an index, leaving the card in the hand.
	 *
	 * @require the index is a valid index of a card in the hand array
	 * @param {number} index - index of a card in the this.hand to be returned.
	 * @return {Card} a card in the hand at the given index
	 */
	this.getCard = function (index) {
		let card = null;
		if (index < this.hand.length) {
			card = this.hand[index];
		}
		return card;
	}
	/**
	 * Checks if the hand contains a possible set.
	 * 
	 * @return {Boolean} true if the hand has at least 3 cards that make up a set
	 */
	this.handContainsSet = function () {
		return cards_contain_set(this.hand).length > 0;
	}

	/**
	 * Gives the index of a card that is a part of a possible set. Index is -1 if no card exists.
	 * 
	 * @return {Number} index of a card that is a part of a possible set
	 */
	this.getHint = function () {
		return cards_contain_set(this.hand)[0].index;
	}

	/**
	 * Returns an array of 3 cards in the hand that make up a set
	 * 
	 * @return {Array(Card)} an array of cards that make up a set, empty if there is no set in the hand.
	 */
	this.getSet = function () {
		return cards_contain_set(this.hand);
	}

	/**
	 * Checks if the given cards form a set.
	 * 
	 * @param {Card} card1 - one of the cards to be checked with the others
	 * @param {Card} card2 - one of the cards to be checked with the others
	 * @param {Card} card3 - one of the cards to be checked with the others
	 * @returns {Boolean} true if the given cards form a set.
	 */
	this.isSelectionSet = function (card1, card2, card3) {
		return is_set(card1, card2, card3);
	}

	/**
	 * Reports the amount of cards left in the deck
	 * 
	 * @return [Number] number of cards left in the deck.
	 */
	this.amountInDeck = function () {
		return this.deck.remaining_amount();
	}

	/**
	 * Deals cards into the hand from the deck. Initially deals [this.this.DEFAULT_HAND_SIZE] cards
	 * into the deck, and then adds [this.this.DEFAULT_DEAL_SIZE]. If given an array of indices 
	 * [indices], it will replace the cards at the given indices with cards from the deck. 
	 * If the deck is empty, it will remove the cards at those indices from the hand and 
	 * shift the remaining cards in the hand.
	 * 
	 * @require indices to either be left out or contain valid indices for the hand array
	 * @param {null, Array(Number)} indices - list of indices of cards to be replaced from the 
	 * 	hand.
	 * @return {Array(Card)} current array of cards in the hand
	 */
	this.dealHand = function (indices = []) {
		if (indices == null || indices.length == 0) {
			if (this.hand.length == 0) {
				// initialize hand with 12 cards
				let count = DEFAULT_HAND_SIZE;
				while (count > 0) {
					card = this.deck.dealCard();
					card.setIndex(this.hand.length);
					this.hand.push(card);
					count--;
				}
			} else {
				// add 3 cards to a hand
				let count = DEFAULT_DEAL_SIZE;
				while (count > 0 && this.deck.remaining_amount() > 0) {
					card = this.deck.dealCard();
					card.setIndex(this.hand.length);
					this.hand.push(card);
					count--;
				}
			}
		} else {
			// Replace the cards at the given indices with new cards from the deck
			let update_indices = false;

			indices.forEach((index) => {
				if (!this.deck.isEmpty() && this.hand.length <= DEFAULT_HAND_SIZE) {
					this.hand[index].setIndex(); // sets index to empty index
					this.hand[index] = this.deck.dealCard();
					this.hand[index].setIndex(index);
				} else {
					// mark card for removal
					this.hand[index].setIndex(); // sets index to empty index
					this.hand[index] = null;
					update_indices = true;
				}
			});
			if (update_indices) {
				this.hand = this.hand.filter((card) => card !== null);
				this.hand.forEach((card, index) => {
					this.hand[index].setIndex(index);
				});
			}
		}
	}
	/**
	 * Initializes the this.hand array with at least [this.this.DEFAULT_HAND_SIZE] cards (will add three
	 * cards until a set is possible in the hand).
	 *
	 * @return {Array(Card)} an array of cards, representing the current hand
	 */
	this.initializeHand = function () {
		this.hand = [];
		this.dealFullHand();
	}

	// private methods ----------------------------------------------------

	/**
	 * Checks if the given features either all three match or are all three unique from each 
	 * other.
	 *
	 * @require the three features to be of the same Card Property type
	 * @param {number | string} feature1, feature2, feature3 - the same feature type of three 
	 * 	cards.
	 * @return {Boolean} true if all three features are the same or completely different.
	 */
	function set_condition(feature1, feature2, feature3) {
		let result = feature1 == feature2 && feature2 == feature3;

		if (!result) {
			result = feature1 != feature2 && feature2 != feature3 && feature1 != feature3;
		}

		return result;
	}

	/**
	 * Checks if the given cards meet the set condition for the number of shapes on each
	 * card.
	 *
	 * @param {Card} card1, card2, card3 - the cards to compare with each other
	 * @return {Boolean} true if all three cards meet the set condition for number of shapes
	 */
	function number_condition(card1, card2, card3) {
		return set_condition(card1.numShapes, card2.numShapes, card3.numShapes);
	}

	/**
	 * Checks if the given cards meet the set condition for the types of shapes on each
	 * card.
	 * 
	 * @param {Card} card1, card2, card3 - the cards to compare with each other.
	 * @return {Boolean}true if all three cards meet the set condition for the type of shapes	
	 */
	function shape_condition(card1, card2, card3) {
		return set_condition(card1.shape, card2.shape, card3.shape);
	}

	/**
	 * Checks if the given cards meet the set condition for the types of shadding of shapes
	 * on each card.
	 *
	 * @param {Card} card1, card2, card3 - the cards to compare with each other.
	 * @return {Boolean} true if all three cards meet the set condition for types of shading
	 */
	function shading_condition(card1, card2, card3) {
		return set_condition(card1.shading, card2.shading, card3.shading);
	}
	/**
	 * Checks if the given cards meet the set condition for the color of shapes on each card.
	 * 
	 * @param {Card} card1, card2, card3 - the cards to compare with each other.
	 * @return {Boolean} true if all three cards meet the set condition for color
	 */
	function color_condition(card1, card2, card3) {
		return set_condition(card1.color, card2.color, card3.color);
	}
	/**
	 * Checks if the given cards meet the set condition for all 4 set conditions.
	 *
	 * @param {Card} card1, card2, card3 - the cards to compare with each other.
	 * @return {Boolean} true if all three cards meet all of the set conditions
	 */
	function is_set(card1, card2, card3) {
		const numberMatched = number_condition(card1, card2, card3);
		const shapeMatched = shape_condition(card1, card2, card3);
		const shadingMatched = shading_condition(card1, card2, card3);
		const colorMatched = color_condition(card1, card2, card3);

		return numberMatched && shapeMatched && shadingMatched && colorMatched;
	}
	/**
	 * Find the 3 card that make up a set. Return an empty array if none are found.
	 *
	 * @param {Array(Card)} cards - the array cards to compare with each other
	 * @return {number} return the index of card that is a part of set.
	 */
	function cards_contain_set(cards) {
		index_a = 0;
		index_b = index_a + 1;
		index_c = index_b + 1;

		while (index_a < cards.length - 2) {
			while (index_b < cards.length - 1) {
				while (index_c < cards.length) {
					if (is_set(cards[index_a], cards[index_b], cards[index_c])) {
						return [cards[index_a], cards[index_b], cards[index_c]];
					}
					index_c += 1;
				}
				index_b += 1;
				index_c = index_b + 1;
			}

			index_a += 1;
			index_b = index_a + 1;
			index_c = index_b + 1;
		}

		return [];
	}
}