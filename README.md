# <font color=red>Deadline is October 31 at 11:59pm</font>
---

*** Goal: have the game working by Wednesday ***

# We have three things to do on Saturday:
+ [ ] Select the next project manager (Adam Lechliter)
+ [ ] Plan out and distribute the tasks needed for project 2
---
# (Review) How to create a branch
## First time
```
git clone git@github.com:cse-3901-sharkey/Butterfly.git
cd Butterfly
git checkout -b  replaceItWithYourBranchName
git push --set-upstream origin replaceItWithYourBranchName
```
## Next time
```
git pull origin main
git add -A
git commit -m "replaceItWithYourCommitMessage"
git push 
```
---
---
# Module card 

***Developer: Adam Lechliter***

## Card class, CardSet class, and DisplaySet class
+ Convert the CardModule from project 1 into JavaScript

---
# Module player 
***Developer: Songyuan Wu***

## Player class
+ convert the player class from project 1 into JavaScript
+ Talked about combining the player class with the computer player

# Module View
***Developer: Ben Mathys***

## set-view.html
+ Purpose: create an outline of the webpage of all the content/sections
+ Use div with a unique id to separate different sections of the page
  + example: create a \<div\> with an id "main-menu" that contains all of the buttons and messages for setting up the start of the game (see the Ruby GUI for an idea of how to structure the main menu)
+ include empty div sections that the set-view.js will populate with content
  + a div section for the player buttons
  + a div section for the cards in the current hand 

## set-view.js
+ Purpose: keeps track of the current state of the game
+ Subscribes functions to events for button elements
+ Call functions from the set-controller to check if game actions were valid, if the game has completed, etc.
+ Call functions from the set-controller to update the current game mode, add players to the game, etc.

---
# Module Controller
***Developer: Lucas Wu***

## set-controller.js
+ Purpose: handle the game logic of set given the current state of the game provided by the set-view
  + contains the DisplaySet for the game (the deck of cards and the current hand)
  + contains the list of current players
  + current selection of cards (list of indices or cards, whichever way you want to implement it)
+ Function: isGameComplete - determine if the game has completed based on the hand (if it contains a set) (returns boolean value)
+ Function: getHand - return the current hand (an array of cards)
+ Function: addCardToSelection - given a card, add the card to the list of selected cards. Return false if the card cannot be added to the selection.
+ Function: removeCardFromSelection - given a card, remove that card from the list of selected cards (do nothing if that card wasn't selected).
+ Function: clearSelection - remove all selected cards from the list of selected cards.
+ Function: addPlayer - given a player name, add that player to the list of current players
+ (optional, we might not need it) Function: removePlayer - given a player name, remove that player from the list
+ Function: isSelectionSet - Determine if the selected cards create a set, if they do, deal a new hand (replace those cards with deal_full_hand(card indices) and clear selection (returns a boolean)
+ You can add any other functions you think would make sense for this module.
  + Make sure you communicate with the person creating the set-view when you want to add new functionality to the controller since the view and the controller depend on each other.

---
# Module Extra Credit
***Developer: Jing Wen***

## Features
+ We talked about adding some features that we created in the Ruby version (ie. timer)
+ You can work on adding any additional features you want.

