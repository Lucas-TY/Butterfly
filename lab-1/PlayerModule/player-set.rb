require_relative './player.rb'
module PlayerModule

  class PlayerSet
    # a class that represents the profile of one or more players participating in this game
    #
    # @attr_reader no_of_players [Number] number of players participating in this game
    #
    # @author Lucas Wu / Jing Wen

    attr_reader :no_of_players;
    # initialize the players list
    # @return [PlayerSet] a new instance of type Players
    def initialize()
      @players_list=[];
      @no_of_players=0

    end
    # add a player to the game
    #
    # @require the the player is not the game
    # @param name [String] the name of the specific player
    # @return [Player] the player that just added
    # @return [Nil] if the name is aready exsit.
    def add_player(name)
      return nil if player_exsit?(name);
      @no_of_players+=1
      player=Player.new(name)
      @players_list.push player
      player
    end
    
    # delete a player to the game
    #
    # @require the the player is in the game
    # @param name [String] the name of the specific player
    # @return [Player] the player that just deleted
    # @return [Nil] if player is not in the game
    def delete_player!(name)
      
      for element in @players_list do
        if element.player_name == name
          @no_of_players-=1
          @players_list.delete(element)
          return element
        end
      end
      return nil
    end

    # return a specific player's score
    # @require the the player is in the game
    # @param name [String] the name of the specific player
    # @return [Player] that player you are looking for 
    # @return [Nil]if the player does not exsit
    def players_search(name)
      for element in @players_list do
        return element if element.player_name == name;
      end
      nil
    end


    # reset all player's score
    def reset_all_score!
      for element in @players_list
        element.score_change_to(0)
      end
    end
    

    
    # return a specific player's score
    #
    # @param name [String] the name of a specific player
    # @return the score [Number]of one specific player
    # @return the nil if player does not exist
    def players_score_check (name)
      for element in @players_list do
        if element.player_name == name
          return element.player_score
        end
      end
      nil
    end

    # display the highest score in this game
    #
    # @return the highest score [Number]
    def players_highest_score
      highest_score=0
      for element in @players_list do

        highest_score=element.player_score  if element.player_score>highest_score ;

      end
      highest_score
    end

    


    # check is the player already in the game
    #
    # @param name [String] the name of a specific player
    # @return [Boolean] true the player is already in the game
    def player_exsit?(name)
      result=false
      for element in @players_list do
        if element.player_name == name
           result=true
           return result
        end
      end
      result
    end

    # return a array that has all players name
    #
    # @return [Array(Sting)] that has all player's name
    def players_name
      players=[]
      for element in @players_list do
        players.append element.player_name 
           
      end
      players
    end

  
  end
end