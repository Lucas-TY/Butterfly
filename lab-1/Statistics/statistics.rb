require "../CardModule/display-card-set.rb"
require "../PlayerModule/player-set.rb"

setDisplay=CardModule::DisplayCardSet.new
players=PlayerModule::PlayerSet.new

digits=0..9
#init 10 computer player
digits.each do |num|
	players.add_computer_player(num.to_s,0.1)
end


card_id_dict={}
id_card_dict={}
i=0
#give each card a unique id
CardModule::Card.NUM_SHAPES.each do |num|
	CardModule::Card.SHAPES.each do |shape|
		CardModule::Card.SHADING.each do |shading|
			CardModule::Card.COLOR.each do |color|
				#cache a image
				card_id_dict["#{color}_#{shading}_#{shape}_#{num}"]=i
				id_card_dict[i]="#{color}_#{shading}_#{shape}_#{num}"
				i+=1
			end
		end
	end
end


sets_appear={}


#computer
setDisplay.deal_full_hand!
turns=1..200000
turns.each do |turn_num|
	puts turn_num
	if setDisplay.hand_contains_set?
		players.players_list.each do |player|
			if player.can_i_win?
				cards=setDisplay.get_set
				card_ids=cards.map{|card| card_id_dict["#{card.color}_#{card.shading}_#{card.shape}_#{card.num_shapes}"]}
				sorted=card_ids.sort
				if sets_appear[sorted]==nil
					sets_appear[sorted]=1
				else
					sets_appear[sorted]+=1
				end
				ans=cards.map {|card| card.index}
				setDisplay.deal_full_hand!(ans)
				player.score_add(3)
				break
			end
		end
	else
		setDisplay.deck.normal!
		setDisplay.hand=[]
		setDisplay.deal_full_hand!
	end
end

file=File.new("statistics-result.txt","w")

sets_appear.each do |key,value|
	file.syswrite("#{id_card_dict[key[0]]} #{id_card_dict[key[1]]} #{id_card_dict[key[2]]} #{value}\n")
end
file.close
puts sets_appear.length
