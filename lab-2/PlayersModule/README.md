README - Player Module

Player Class

    - Initialize three global variables
        + no_of_players: number of players participating in this game
        + DEFAULT_SCORE: default initial score for each player
        + players_list: storing all of the players' information
    
    - Example:
        + Player 1 -- jack
        + Player 2 -- jimmy

    - Initialize the profile of each new player
        + example:
            [{player name: jack, player score = 0}, 
            {player name: jimmy, player score = 0}]

    - Update the profile of each player
        + example:
            If jack won 100 points.
            [{player name: jack, player score = 100}, 
            {player name: jimmy, player score = 0}]

    - Display all or individual players's profile

    - Report the total number of players participating in this game.
        + example:
            - # of players: 2