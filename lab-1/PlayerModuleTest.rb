require_relative "./PlayerModule/player-set.rb"
puts "\ntest adding"
game=PlayerModule::PlayerSet.new;
game.add_player("jack");
game.add_player("lucas");

puts "num of player #{}"

puts "\ntest searchinging"
jack=game.players_search("jack")
lucas=game.players_search("lucas")
puts game.no_of_players

puts "\ntest player"
puts jack.player_name
puts jack.player_score

puts  "\nadd score test: #{jack.score_add(10)}"
puts "jack :#{game.players_search("jack").player_score}"
puts "lucas :#{game.players_search("lucas").player_score}"
puts "highest score should be #{game.players_highest_score}"

puts  "\nadd score test: #{jack.score_add(-20)}"
puts "jack :#{game.players_search("jack").player_score}"
puts "lucas :#{game.players_search("lucas").player_score}"
puts "highest score should be #{game.players_highest_score}"

puts  "\nadd score test: #{jack.score_add(50)}"
puts  "add score test: #{lucas.score_add(60)}"
puts "jack :#{game.players_search("jack").player_score}"
puts "lucas :#{game.players_search("lucas").player_score}"
puts "highest score should be #{game.players_highest_score}"

puts "\ntest search"

puts game.players_search("jack").player_name
puts game.players_search("lucas").player_name
puts "\ntest score search check"
puts "jack: #{game.players_score_check("jack")}"
puts "lucas: #{game.players_score_check("lucas")}"
puts "leon: #{game.players_score_check("leon")}"

puts "\ntest reset"
game.reset_all_score!
puts "jack :#{game.players_search("jack").player_score}"
puts "lucas :#{game.players_search("lucas").player_score}"
puts "highest score should be #{game.players_highest_score}"
puts "\ntest exsit"
puts game.player_exsit?("lucas")
puts game.player_exsit?("leon")
puts "\ntest delete"
game=PlayerModule::PlayerSet.new;
game.delete_player!("jack");
game.delete_player!("leon");
puts game.no_of_players
puts "\ntest adding"
game=PlayerModule::PlayerSet.new;
game.add_player("jack");
game.add_player("jack");
game.add_player("lucas");
puts "players: #{game.no_of_players}\n"
puts "playersName: #{game.players_name}\n"
puts "\ntest delete"
game.delete_player!("jack");
puts "playersName: #{game.players_name}\n"
puts "players: #{game.no_of_players}\n"
game.delete_player!("leon");
puts "players: #{game.no_of_players}\n"
puts "playersName: #{game.players_name}\n"
game.delete_player!("lucas");
puts "players: #{game.no_of_players}\n"
puts "playersName: #{game.players_name}\n"