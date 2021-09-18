# <font color=red>Deadline is Sep 26 at 11:59pm</font>
---


# We have three things to do on saturday:
+ [ ] Read through the whole document and make sure everyone agree with it
+ [ ] Pick a module and write some api document for your part(just let others know how to use your function)
+ [ ] Build your branch on both remote repo and your locale laptop, and make sure your are working on your own branch.
---
# How to create a branch
## First time
```
git clone git@github.com:cse-3901-sharkey/Butterfly.git
cd butterfly
git checkout -b  replaceItWithYourBranchName
git push --set-upstream origin replaceItWithYourBranchName
```
## Next time
```
git pull origin main
git add -A
git commit -m "replaceItWithYourCommitMessage"
git push replaceItWithYourBranchName
```
---
---
# Module card 

***This part needs to be done by the end of this week***

## Card class
+ include card properties and card index
+ a function that init the card by using input parameters.
+ functions that can return card's property(can't change).

## Card set class
+ Use iteration to generate 81 unique cards.
+ A random select method that return a card from the card set
  + Delete it from set
  + return nil if set is empty
+ function that return how many cards remain

## Display card set class
+ Use iteration to get cards that will be selected (no enough cards???)
+ A funtion to select cards from Card set and update it.
+ + A funtion that return the set.

---
# Module player 
***This part needs to be done by the end of this week***

## Player class
+ include player properties(name,score,etc.)
+ a function that init the player by using input parameters.
+ functions that can return player's property(can't change).
+ a function that can update player's score.
---
# Module interaction 
***This part needs to be done by 9/21***

## Functions
+ Function play: ask player to input card index that they selected, use other function to check correctness, return true or false
+ Fountion correctness: If true, update score and update display card set. If false.... return true or false
+ Function display: print out display card set.
---
# Module main
***This part needs to be done by 9/21***
+ begin: init everything by asking the user, then play the game until condition matched(print out cards remain, player information, correcness information)
+ end: show the result

