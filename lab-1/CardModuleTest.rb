require_relative "./CardModule/display-card-set.rb"

def print_card(card)
	if card
		puts "#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}"
	else
		puts "Card doesn't exist at that index"
	end
end

def print_info(hand, num_left)
	puts "\nCurrent hand:"
	hand.each { |card| print_card card }
	puts "Cards left in deck: #{num_left}"
end


displaySet = CardModule::DisplayCardSet.new

print_info(displaySet.hand, displaySet.amount_in_deck)

print_info(displaySet.deal_full_hand!([0, 4, 1]), displaySet.amount_in_deck)

print "Chosen card --> "
print_card(displaySet.get_card(11))

print "Card does not exist --> "
print_card(displaySet.get_card(12))

puts "\nAdding 3 cards to the deck (usually done automatically if a set isn't possible)"
print_info(displaySet.deal_full_hand!, displaySet.amount_in_deck)

puts "\nDoes hand contain a set? #{displaySet.hand_contains_set?}"

print "\nDo the cards at indices 0, 1, and 2 create a set? "
isSet = displaySet.is_selection_set?(displaySet.get_card(0), displaySet.get_card(1), displaySet.get_card(2));
puts "#{isSet}"

puts "\nAn example of three cards that do create a set:"
card1 = CardModule::Card.new(CardModule::Card.NUM_SHAPES[0], CardModule::Card.SHAPES[0], CardModule::Card.SHADING[0], CardModule::Card.COLOR[0])
card2= CardModule::Card.new(CardModule::Card.NUM_SHAPES[1], CardModule::Card.SHAPES[1], CardModule::Card.SHADING[1], CardModule::Card.COLOR[1])
card3 = CardModule::Card.new(CardModule::Card.NUM_SHAPES[2], CardModule::Card.SHAPES[2], CardModule::Card.SHADING[2], CardModule::Card.COLOR[2])
print_card(card1)
print_card(card2)
print_card(card3)
puts "Are they a set? #{displaySet.is_selection_set?(card1, card2, card3)}"

puts "\nEmpty deck"

until displaySet.amount_in_deck == 0
	displaySet.deal_full_hand!([0, 3, 6])
end

print_info(displaySet.hand, displaySet.amount_in_deck)

puts "Take out three more cards"
print_info(displaySet.deal_full_hand!([0, 5, 11]), displaySet.amount_in_deck)

puts "\nRemove until no sets are possible"

while displaySet.hand_contains_set?
	displaySet.deal_full_hand!([0, 1, 2])
end

print_info(displaySet.hand, displaySet.amount_in_deck)
