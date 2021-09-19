require_relative './card.rb'
require_relative './card-set.rb'

module CardModule

	# A class that manages a deck of cards (CardSet) and deals cards to a hand.
	# This class can also check if the hand has a possible set and check if a given
	# list of cards create a set.
	#
	# @attr_reader hand [Array(Card)] array of the current cards in the hand
	#
	# @author Adam Lechliter

	class DisplayCardSet

		@@DEFAULT_HAND_SIZE = 12;
		@@DEFAULT_DEAL_SIZE = 3;

		attr_reader :hand;

		# Initializes a new instance of a DisplayCardSet
		#
		# @return [DisplayCardSet] a new instance of DisplayCardSet
		def initialize 
			@deck = CardSet.new
			initialize_hand!
		end

		# public methods ----------------------------------------------------

		# Deals cards into the hand from the deck. Initially deals [@@DEFAULT_HAND_SIZE] cards
		# into the deck, and then adds [@@DEFAULT_DEAL_SIZE] until the hand contains a set. If
		# given an array of indices [indices], it will replace the cards at the given indices
		# with cards from the deck. If the deck is empty, it will remove the cards at those 
		# indices from the hand and shift the remaining cards in the deck.
		#
		# @require indices to either be left out or contain valid indices for the hand array
		# @param indices [nil, Array(Number)] list of indices of cards to be replaced from the 
		# 	hand.
		# @return [Array(Card)] current array of cards in the hand
		def deal_full_hand!(indices = [])
			self.deal_hand!(indices)

			until self.hand_contains_set? || @deck.is_empty?
				self.deal_hand!
			end

			@hand
		end

		# Retrieves a card from the hand given an index, leaving the card in the hand.
		#
		# @require the index is a valid index of a card in the hand array
		# @param index [Number] index of a card in the @hand to be returned.
		# @return [Card] a card in the hand at the given index
		def get_card(index)
			card = nil
			if(index < @hand.length)
				card = @hand[index]
			end
			card
		end

		# Checks if the hand contains a possible set.
		#
		# @return [Boolean] true if the hand has at least 3 cards that make up a set
		def hand_contains_set?
			cards_contain_set?(@hand).length > 0
		end

		# Gives the index of a card that is a part of a possible set. Index is -1 if no card exists.
		#
		# @return [Number] index of a card that is a part of a possible set
		def get_hint
			cards_contain_set?(@hand)[0].index
		end

		# Returns an array of 3 cards in the hand that make up a set
		#
		# @return [Array(Card)] an array of cards that make up a set, empty if there is no set in the hand.
		def get_set
			cards_contain_set?(@hand)
		end

		# Checks if the given cards form a set.
		#
		# @param card1 [Card] one of the cards to be checked with the others
		# @param card2 [Card] one of the cards to be checked with the others
		# @param card3 [Card] one of the cards to be checked with the others
		# @return [Boolean] true if the given cards form a set.
		def is_selection_set?(card1, card2, card3)
			is_set?(card1, card2, card3)
		end

		# Reports the amount of cards left in the deck
		#
		# @return [Number] number of cards left in the deck.
		def amount_in_deck
			@deck.remaining_amount
		end

		# private methods ----------------------------------------------------

		# Initializes the @hand array with at least [@@DEFAULT_HAND_SIZE] cards (will add three
		# cards until a set is possible in the hand).
		#
		# @return [Array(Card)] an array of cards, representing the current hand
		private def initialize_hand!
			@hand = [];
			self.deal_full_hand!
		end

		# Deals cards into the hand from the deck. Initially deals [@@DEFAULT_HAND_SIZE] cards
		# into the deck, and then adds [@@DEFAULT_DEAL_SIZE]. If given an array of indices 
		# [indices], it will replace the cards at the given indices with cards from the deck. 
		# If the deck is empty, it will remove the cards at those indices from the hand and 
		# shift the remaining cards in the hand.
		#
		# @require indices to either be left out or contain valid indices for the hand array
		# @param indices [nil, Array(Number)] list of indices of cards to be replaced from the 
		# 	hand.
		# @return [Array(Card)] current array of cards in the hand
		private def deal_hand!(indices = [])
			if indices == nil || indices.length == 0
				if @hand.length == 0
					# initialize hand with 12 cards
					count = @@DEFAULT_HAND_SIZE
					while count > 0
						card = @deck.deal_card!
						card.set_index!(@hand.length)
						@hand.push(card)
						count -= 1
					end
				else
					# add 3 cards to a hand
					count = @@DEFAULT_DEAL_SIZE;
					while count > 0 && @deck.remaining_amount > 0
						card = @deck.deal_card!
						card.set_index!(@hand.length)
						@hand.push(card)
						count -= 1
					end
				end
			else 
				# Replace the cards at the given indices with new cards from the deck
				update_indices = false
				indices.each do |index|
					if @deck.remaining_amount > 0
						@hand[index].set_index! # sets index to empty index
						@hand[index] = @deck.deal_card!
						@hand[index].set_index! index
					else
						# mark card for removal
						@hand[index].set_index! # sets index to empty index
						@hand[index] = nil
						update_indices = true
					end
				end
				if update_indices
					@hand.select! { |card| card != nil }
					@hand.each_index do |index|
						@hand[index].set_index! index
					end
				end

			end
				
		end


		# Checks if the given features either all three match or are all three unique from each 
		# other.
		#
		# @require the three features to be of the same Card Property type
		# @param feature1, feature2, feature3 [Number, Symbol] the same feature type of three 
		# 	cards.
		# @return [Boolean] true if all three features are the same or completely different.
		private def set_condition?(feature1, feature2, feature3)
			result = feature1 == feature2 && feature2 == feature3

			if !result
				result = feature1 != feature2 && feature2 != feature3 && feature1 != feature3
			end

			result
		end

		# Checks if the given cards meet the set condition for the number of shapes on each
		# card.
		#
		# @param card1, card2, card3 [Card] the cards to compare with each other
		# @return [Boolean] true if all three cards meet the set condition for number of shapes	
		private def number_condition?(card1, card2, card3)
			set_condition?(card1.num_shapes, card2.num_shapes, card3.num_shapes)
		end

		# Checks if the given cards meet the set condition for the types of shapes on each
		# card.
		#
		# @param card1, card2, card3 [Card] the cards to compare with each other.
		# @return [Boolean] true if all three cards meet the set condition for the type of shapes	
		private def shape_condition?(card1, card2, card3)
			set_condition?(card1.shape, card2.shape, card3.shape)
		end

		# Checks if the given cards meet the set condition for the types of shadding of shapes
		# on each card.
		#
		# @param card1, card2, card3 [Card] the cards to compare with each other.
		# @return [Boolean] true if all three cards meet the set condition for types of shading	
		private def shading_condition?(card1, card2, card3)
			set_condition?(card1.shading, card2.shading, card3.shading)
		end

		# Checks if the given cards meet the set condition for the color of shapes on each card.
		#
		# @param card1, card2, card3 [Card] the cards to compare with each other.
		# @return [Boolean] true if all three cards meet the set condition for color
		private def color_condition?(card1, card2, card3)
			set_condition?(card1.color, card2.color, card3.color)
		end

		# Checks if the given cards meet the set condition for all 4 set conditions.
		#
		# @param card1, card2, card3 [Card] the cards to compare with each other.
		# @return [Boolean] true if all three cards meet all of the set conditions
		private def is_set?(card1, card2, card3)
			numberMatched = number_condition?(card1, card2, card3);
			shapeMatched = shape_condition?(card1, card2, card3);
			shadingMatched = shading_condition?(card1, card2, card3);
			colorMatched = color_condition?(card1, card2, card3);

			numberMatched && shapeMatched && shadingMatched && colorMatched
		end	

		# Find the 3 card that make up a set. Return an empty array if none are found.
		#
		# @param cards [Array(Card)] the array cards to compare with each other
		# @return [Number] return the index of card that is a part of set.
		private def cards_contain_set?(cards)
			index_a = 0;
			index_b = index_a + 1;
			index_c = index_b + 1;

			while index_a < cards.length - 2
				while index_b < cards.length - 1
					while index_c < cards.length
						if(is_set?(cards[index_a], cards[index_b], cards[index_c]))
							return [cards[index_a], cards[index_b], cards[index_c]];
						end
						index_c += 1;
					end
					index_b += 1;
					index_c = index_b + 1;
				end

				index_a += 1;
				index_b = index_a + 1;
				index_c = index_b + 1;
			end

			return [];
		end
	end
end