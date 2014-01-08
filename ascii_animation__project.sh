#!/bin/bash
# the above is not actually necessary for me, except of a cleaner debugging / coding ( .. )

####
## -- ASCII_ANIMATION FRAMEWORK --
##
##        Game / Project file
##
####

## --

# you can define your variables and function in below

# "setup()" function - 'll run once at the beginning of the game / project execution -- ! MUST BE PRESENT ( can be empty )
setup(){
  
  saveContext # save cursor position before drawing
  echo -en "user text in setup() function ..."
  restoreContext # restore the cursor position after drawing
  
  sleep 5 # wait a little bit for our user to see the message displayed above ( as we're in the "setup()" function, it's ok to invoke the "sleep()" function -> aka it won't mess with the framerate )
  
}

# "draw()" function - 'll be called repeatedly in an infinite loop until the user hit "Ctrl-C" -- ! MUST BE PRESENT ( can be empty )
draw(){
  
  saveContext # save cursor position before drawing
  drawCenteredText "Hello World end-user !" # draw a one-line text, centered
  restoreContext # restore the cursor position after drawing
  
}