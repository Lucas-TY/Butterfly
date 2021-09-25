require_relative "./CardModule/display-card-set.rb"
require_relative "./PlayerModule/player-set.rb"
Shoes.app width:630, height:500,scroll:false,title:"Team Butterfly" ,resizable: false do


  #Buttons

  #AddPlayer button, it will add player name in to players set, if it's not an empty string
  @bth_Add=button "Add" ,:top=>250,:left=>10 do
    if @editline.text !="" 
    @players.add_player!( @editline.text)
   
    @editline.text=""  
    @box.items=@players.players_name
    scoreboard()
    end  
  end
  
  #Start button, it will start the game if there are more than one player in the game
  @bth_start=button "Start" ,:top=>430,:left=>10,:width=>120 do
    if @players.no_of_players ==1 &&@running==false
      game_start()
    end
    @running=true
  end

  #Exit button, it will exit the program pnce clicked
  @bth_exit = button 'Exit',:top=>460,:left=>10,:width=>120  do
    exit()
  end

  #Ok button, it will check the answer if the program is still running and there are more than one player in the game
  @bth_ok = button 'OK',  :top=>380,:left=>10 do
    if  @running &&@players.no_of_players >=1&&@setDisplay.hand_contains_set? 
      check!()
    end
    if @running &&@players.no_of_players >=1&&!@setDisplay.hand_contains_set?  
      @an.stop
      @timer_left.remove
      @clock.remove
      @print_message.text="Game finished, please exit"
    end
  end

  #Hint button, it show the set index to screen if the program is still running and there are more than one player in the game
  @bth_hint = button "Hint", :top=>380,:left=>95 do
    if @running &&@players.no_of_players >=1 &&@setDisplay.hand_contains_set? 
      if  @hintLevel == 0 #No hints used and a hint is requested, one card index given.
        @hint_card.text ="Card with index #{@setDisplay.get_hint} is \npart of a set!"
        @hintLevel += 1
      else  @hintLevel ==1 #One hint already used and another requested, full set given.
        card_message="The cards that make up a \nset are:\n"
        
        @setDisplay.get_set.each { |card| card_message=card_message+ "#{card.index}: #{card.num_shapes} #{card.shape} #{card.shading} #{card.color}\n"}
        @hint_card.text= card_message
        @hintLevel +=1
      end
    end
  end

  #Functions 

  #Clock it will draw a clodck on the screen once it is called
  def draw_clock
    stack left:240,top:420,margin_top:10, width:500 do
      @clock = progress width: 1.0
      @timer_left=para :emphasis =>"oblique",:font=> "10px"
      @an=animate 24 do  
        @clock.fraction = ((@LIMIT-@time) ) /@LIMIT
        if @time< @LIMIT

            @time+=(1/24.0)
            @timer_left.text="#{(@LIMIT-@time).round} seconds left for this round"
        
        else
            answer=@setDisplay.get_set
            answer.map! { |card| card.index}
            @setDisplay.deal_full_hand!(answer)
            display_hand(@setDisplay.hand, @setDisplay.amount_in_deck)
            if @running &&@players.no_of_players >=1&&!@setDisplay.hand_contains_set?  
              @an.stop
              @timer_left.remove
              @clock.remove
              @print_message.text="Game finished, please exit"
            end
            @time=0
        end
      end
    end
  end
   # Takes an array of 3 strings and checks if their numeric values are all different.
  #
  # @param indices Array[String] the array of strings to check
  # @return [Boolean] true if all different, false otherwise
  def all_different?(indices)
    indices[0] != indices[1] && indices[0] != indices[2] && indices[1] != indices[2]
  end
  #display cards on the screen
  def display_hand(hand, numberCardsLeft)
      
    if @card_image.length<hand.length
    hand.each do |card|
      stack top:100+card.index/4*100,left:230+(card.index%4)*80 do
      @card_image.push (image"./CardImages/#{card.image_file}" )
        stack margin_left:20 do
          @card_index.push para card.index
        end
      end
    end
  
  end
    while @card_image.length>hand.length
      delete=@card_image.pop
      delete.remove
      delete=@card_index.pop
      delete.remove
    end
      hand.each do |card|
        @card_image[card.index].path="./CardImages/#{card.image_file}"
      end
    
    @player_input.text="Cards left in deck: #{numberCardsLeft}"
  end

  #It will check whether user input is a valid set
  #@require player name and a valid input
  #Different printouts based off hint level. After getting a full set as a hint, players may not request another hint until a set is entered.
  def check!

    playerToScore = @players.players_search(@player_choose)
    if playerToScore != nil
      display_hand(@setDisplay.hand, @setDisplay.amount_in_deck)
      cardIndices = @response.text.chomp.split()
      validIndices=false
      if cardIndices.length == 3
        #Flip validIndices to true, then flip to false if any value was a string or greater than the number of cards in the hand.
        validIndices = !validIndices
        cardIndices.each { |index| validIndices = false if (index.to_i == 0 && index != "0") || index.to_i >= @setDisplay.hand.length }
        #Only check if the values are all different if validIndices is still true, as there are 3 values and they are all valid integers.
        validIndices = all_different?(cardIndices) if validIndices
      end
      if validIndices
        isSet = @setDisplay.is_selection_set?(@setDisplay.get_card(cardIndices[0].to_i), @setDisplay.get_card(cardIndices[1].to_i), @setDisplay.get_card(cardIndices[2].to_i))
      end
      
      if isSet #User entered a valid set, points are given based off the current hint level. Show the scoreboard before continuting.
          @print_message.text= "Valid set! #{@player_choose} gains #{3 - @hintLevel} point(s)!"
          answer=@setDisplay.get_set
          answer.map! { |card| card.index}
          @setDisplay.deal_full_hand!(answer)
          playerToScore.score_add!(3 - @hintLevel)
          playerNames = @players.players_name
          
          @hintLevel = 0
          display_hand(@setDisplay.hand, @setDisplay.amount_in_deck)
          scoreboard()
          @time=0
      else #Invalid set, cycle back to the top without changing the current hint state.
          @print_message.text ="Not a valid set or invalid input!"
          @response.text=""
      end
    end 
  end

  # It will update scoreboard to the screen once it's called
  def scoreboard
    playerNames = @players.players_name
    scorebloard= "--SCOREBOARD--\n"
          for name in playerNames
            scorebloard =scorebloard+"#{name}: #{@players.players_score_check(name)} point(s)\n"
          end
    @hint_card.text=scorebloard
  end
  
  # It will update scoreboard to the screen once it's called
  def game_start
    display_hand(@setDisplay.hand, @setDisplay.amount_in_deck)
    draw_clock()
  end


  # Main Program
  #Print out Welcome
  stack margin: 10  do
  para "Welcome to Set! You may play this game with as many players that are available!\n\n"
  @player_input=para "Cards left in deck: 81"
  end

  #init values
      
  @setDisplay = CardModule::DisplayCardSet.new #Create the display for the hand of cards.
  @hintLevel = 0 #Used to determine which hint has been used. 0 = none, 1  = regular hint, 2 = full set.
  @players = PlayerModule::PlayerSet.new #Creat players set to store players
  @card_image=[] #Card images array to store displayed images
  @card_index=[] #Card images array to store displayed indexs
  @LIMIT=20.0  #Time limit for each round
  @time=0 #Initial time value
  @running=false #whether the program is still running
  # Something that can be used for debug
  #@p = para
  #animate do
  #  button, left, top = self.mouse
  #  @p.replace "mouse: #{button}, #{left}, #{top}"
  #end

  #Input 
  stack left:240,top:400 ,margin_top:10 do
    @print_message=para :emphasis =>"oblique",:font=> "8px"
  end
  stack left:20,margin_top:10 ,height: 80, width:180 , scroll:true do
    @hint_card=para :emphasis =>"italic", :font=> "8px"
  end
  stack top:200,left:10 do
    para "Player", :font=> "10px"
    @editline = edit_line :width => 120
  end
  @choose_names=stack top:280,left:10 do
    para "Choose Player", :font=> "10px"
    @box=list_box items: @players.players_name,width: 120 ,choose: "Player" do |list|
      @player_choose = list.text
    end
  end
  @input_answer=stack top:330,left:10 do
    para "Answer e.g 0 2 5" ,:font=> "10px"
    @response = edit_line :width => 120
  end
  



  
 
end