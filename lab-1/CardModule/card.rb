module CardModule

	# a class that represents a single card in the game Set.
	#
	# @attr_reader num_shapes [Number] number of shapes on the card
	# @attr_reader shape [Symbol] type of shape on the card
	# @attr_reader shading [Symbol] type of shading of the shape
	# @attr_reader color [Symbol] color of the shape
	# @attr_reader index [index] index of the card in a hand (or other collection)
	#
	# @author Adam Lechliter

	class Card
		@@NUM_SHAPES = [1, 2, 3];
		@@SHAPES = [:diamond, :squiggle, :oval];
		@@SHADING = [:solid, :striped, :open];
		@@COLOR = [:red, :green, :purple];

		attr_reader :num_shapes;
		attr_reader :shape;
		attr_reader :shading;
		attr_reader :color;
		attr_reader :index;

		# Initialize a new instance of a Card
		#
		# @param num [Number, #read] number of shapes for the card
		# @param shape [Symbol, #read] the type of shape on the card
		# @param shading [Symbol, #read] the type of shading of the shape
		# @param color [Symbol, #read] the type of color of the shape
		# @return [Card] a new instance of type Card
		def initialize(num, shape, shading, color)
			@num_shapes = num;
			@shape = shape;
			@shading = shading;
			@color = color;
			@index = -1;
		end

		# Changes the index of the card 
		#
		# @param new_index [number, #read] new index of the card
		# @return [Number] index of the card
		def set_index!(new_index)
			@index = new_index;
		end

		# Get the possible amounts of shapes for a set card
		#
		# @return [Array(Number)] array of the different amounts of shapes possible
		def self.NUM_SHAPES
			@@NUM_SHAPES
		end

		# Get the possible shapes that can appear on a set card
		#
		# @return [Array(Symbol)] array of the different shapes possible for set
		def self.SHAPES
			@@SHAPES
		end

		# Get the possible shadings for shapes that can appear on a set card
		#
		# @return [Array(Symbol)] array of the different shadings possible for set
		def self.SHADING
			@@SHADING
		end

		# Get the possible colors for shapes that can appear on a set card
		#
		# @return [Array(Symbol)] array of the different colors possible for set
		def self.COLOR
			@@COLOR
		end

	end
end