module PlayerModule
  
    # a class represents a single player's information
    # @attr_reader player_name [String] name of the player
    # @attr_reader player_score [Number] Score of the player
    # @author Lucas Wu, Jing Wen, Songyuan Wu
      class Player
        attr_reader  :player_name;
        attr_reader  :player_score;
        attr_accessor  :win_prob;
        attr_reader  :is_human;
        # initialize the information of the new player
        #
        # @param name [String] the name of the new player
        # @return [Player] a new instance of type player
        def initialize(name)
          @player_name = name;
          @player_score = 0;
          @is_human=true
        end
        def change_to_computer()
          @is_human=false
        end
        # update the score of the player won or lost
        #
        # @param points [Number] points that the player won or lost
        # @return the updated score
        def score_add!(points)
    
          @player_score += points;
          @player_score = 0 if @player_score < 0;
          @player_score
        end
    
        # update the score of the player won or lost
        #
        # @param name [Number] the players's new score
        # @return the new score
        def score_change_to(score )
          @player_score = score;
          score
        end
        # update the score of the player won or lost
        #
        # @param name [String] the players's new name
        # @return the new name
        def name_change_to(name)
          @player_name = name;
          name
        end



      end
    end