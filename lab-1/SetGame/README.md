# Welcome to Set!

Players: 1+

# System Requirements
Ruby (Developed on v2.7.1)

# How to Start
1. Open the command terminal and navigate to the folder containing the game files.
2. Start the game with ``` ruby SetGame.rb ```

# The Game
In Set, you will have a board of 12 cards by default. If there are no sets in the 12 card board, 3 cards will be added until there is a set on the board. The first player to find a set will say "Set!" and will enter their player name into the console. They will then enter the indices of the cards that make up the set that they found. If they found a valid set, they will earn a point and 3 new cards will be dealt if there were 12 cards on the board. The game ends when the deck is empty.

# Sets
Sets consist of 3 cards with the following properties:
All 3 cards have the SAME shape or have 3 DIFFERENT shapes
All 3 cards are the SAME color or are 3 DIFFERENT colors.
All 3 cards are the SAME shading or have 3 DIFFERENT shadings.
All 3 cards have the SAME number of shapes or have 3 DIFFERENT numbers of shapes.

If all of the following are true, the cards consist of a set.
Here is an example of a set:

1 red solid diamond
2 green striped squiggle
3 blue open oval

Here, the colors are all different, the numbers of shapes are all different,
the shadings are all different and the shapes are all different.

Another example of a set:

1 green solid diamond
1 blue striped diamond
1 red open diamond

Here, the colors are all differnt, the numbers of shapes are all the same, the shadings are all different and the shapes are all the same.
