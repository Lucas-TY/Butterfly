# a class represents a single player's information
class Player

  # initialize the information of the new player
  #
  # @param name [Name, #read] the name of the new player
  # @return the name and the initial score for this player
  def initialize_player(name)
    @player_name = name
    @player_score = 0
  end

  # update the score of the player won or lost
  #
  # @param name [Name, #read] the name of the player
  # @param points [Number, #read] points that the player won or lost
  # @return the name and the score of the player
  def update_player(name, points)
    @player_name = name
    @player_score += points

    @player_score = 0 if @player_score < 0
  end

  # report the player's name
  #
  # @return the player's name
  def player_name
    return @player_name
  end

  # report the player's score
  #
  # @return the player's score
  def player_score
    return @player_score
  end
end
