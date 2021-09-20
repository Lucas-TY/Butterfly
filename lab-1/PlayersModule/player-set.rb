class Players
  # a class that represents the profile of one or more players participating in this game.
  #
  # @attr_reader no_of_players [Number] number of players participating in this game
  # @attr_reader players_list [Array Object] storing all of the players' information

  @@no_of_players = 0
  @@players_list = Array.new

  attr_reader :no_of_players
  attr_reader :players_list
  # initialize each player's profile
  #
  # @param name [Name, #read] the name of the specific player
  # @return an Array object which contains the new player's information
  def player_initialize(name)
    @@no_of_players += 1

    player_info = Hash["player_name" => name, "player_score" => 0]
    @@players_list.append(player_info)
  end

  # update each player's profile
  #
  # @param name [Name, #read] the name of the specific player
  # @param points [Number, #read] the points of the specific player who win or loss, as well as neither
  # @return an Array object which contains the players' updated information
  def player_property_update(name, points)
    for element in @@players_list
      if element["player_name"] == name
        element["player_score"] += points

        element["player_score"] = 0 if element["player_score"] < 0
      end
    end
  end

  # display each player's profile
  #
  # @return an Array object which contains all of players' information
  def all_players_status
    i = 1
    for element in @@players_list
      puts "Player #{i} #############"
      puts "Player Name: #{element["player_name"]}"
      puts "Player Score: #{element["player_score"]}"
      i += 1
    end
  end

  # display one specific player's profile
  #
  # @return an Array object which contains the specific player's information
  def specific_player_status(name)
    for element in @@players_list
      if element["player_name"]  == name
        puts "Player Name: #{element["player_name"]}"
        puts "Player Score: #{element["player_score"]}"
      end
    end
  end

  # report a specific player's score
  #
  # @param name [Name, #read] the name of a specific player
  # @return the score of one specific player
  def player_score(name)
    for element in @@players_list
      if element["player_name"]  == name
        @player_score = element["player_score"]
      end
    end
    return @player_score
  end

  # report the total number of players
  #
  # @return the total number of players
  def total_no_of_players
    puts "Total number of players: #@@no_of_players"
  end

end