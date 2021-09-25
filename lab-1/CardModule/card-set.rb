require_relative './card.rb'

module CardModule

	# a class that represents a deck of cards in the game of Set.
	#
	# @author Adam Lechliter, Jing Wen
	class CardSet

		# Initialize a deck of 81 cards and shuffles the deck
		#
		# @return [CardSet] a new instance of type CardSet
		def initialize
			@deck = []

			Card.NUM_SHAPES.each do |num|
				Card.SHAPES.each do |shape|
					Card.SHADING.each do |shading|
						Card.COLOR.each do |color|
							@deck.push Card.new(num, shape, shading, color)
						end
					end 
				end
			end
			@deck.shuffle!
		end


		def print_deck()
			@deck.each {|card|
				puts "#{card.num_shapes},#{card.shape},#{card.shading},#{card.color}"
			}
		end




		
		# public methods ----------------------------------------------------


		# Deals a card from the deck, removing that card from the deck. Returns nil
		# if the deck is empty. 
		#
		# @return [Card] a card removed from the deck
		def deal_card!
			card = nil
			if @deck.length > 0
				card = @deck.pop
			end
			card
		end

		# reshuffle the cards in normal mode
		def normal!()
			Card.NUM_SHAPES.each do |num|
				Card.SHAPES.each do |shape|
					Card.SHADING.each do |shading|
						Card.COLOR.each do |color|
							@deck.push Card.new(num, shape, shading, color)
						end
					end
				end
			end
			@deck.shuffle!
		end

		# reshuffle the cards in the rookie mode 1
		def rookie_shuffle1!()
			@deck=[]
			temp=[]
			Card.NUM_SHAPES.each do |num|
				Card.SHAPES.each do |shape|
					Card.SHADING.each do |shading|
						Card.COLOR.each do |color|
							temp.push Card.new(num, shape, shading, color)
						end
					end
					temp.shuffle!
					@deck+=temp
					temp=[]
				end
			end
		end

		# reshuffle the cards in rookie mode 2
		def rookie_shuffle2!()
			@deck=[]
			temp=[]
			Card.NUM_SHAPES.each do |num|
				Card.SHAPES.each do |shape|
					Card.SHADING.each do |shading|
						Card.COLOR.each do |color|
							temp.push Card.new(num, shape, shading, color)
						end
					end
				end
				temp.shuffle!
				@deck+=temp
				temp=[]
			end
		end


		# Reports the amount of cards left in the deck 
		#
		# @return [Number] number of cards left in the deck
		def remaining_amount
			@deck.length
		end


		# Returns whether the deck is empty or not 
		#
		# @return [Boolean] true if the deck is empty
		def is_empty?
			@deck.length == 0
		end

	end
end