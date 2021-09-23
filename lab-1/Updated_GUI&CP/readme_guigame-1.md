# Readme of GuiGame

## Some Info Here

if you are looking for how computer play and timer works,you should look at schedule function,this function is a task that run every second to handle these background tasks

## message(text)

display a message on the screen by a alert window
@param text[str] message to show

## create_human_player()

window function of tk
create a human player
use playerset.addplayer method

## create_computer()
window function of tk
create a computer player
use playerset.addplayer method of playerset class

## reset_game()

reset the game cardset and game score
invoked by on_closing func

## on_closing

func invoked when game window is closed by user
this func invokes reset_game

## start_game()

game main window,create game main process here
create buttons and players and their proc
handle click events
create a task that invokes every 1s to handle computer player and timer

## schedule(turn_now,ans)

schedule func
a schedule task for a turn that run every 1 second
@param turn_now[int] this param is used to ensure  
schedule tasks of other turns to be closed by 
compare their turn with global $turn 
@param ans[list] the cached answer of this turn,for computer player



## main program

this part creates all the global var such as setDisplay and players
creates a main windows that control the game
