#!/bin/bash

####
## -- ASCII_ANIMATION FRAMEWORK --
##
## Tiny test framework designed to replicate "P5-like" capabilities
## of drawing from within a terminal window.
##
## This project is sort of a playground as well as "working practices" examples
##
## Nb: it was done under Mac OS C 10.6 & currently tested only on the platform it was coded on
##
##
## by StpephaneAG - 2014
## 
####

## ---- ASCII_ANIMATION FRAMEWORK ---- CODE START ---- ##

## --

#R:
#
# num=`expr $num1 + $num2`
#
# num=$(echo $num1 + $num2 | bc) # for floating point numbers
#
# echo $num

## -- Screen size & stuff related

## SCREEN_SIZE_LINES
SCREEN_SIZE_LINES=`tput lines`
## SCREEN_SIZE_COLS
SCREEN_SIZE_COLS=`tput cols`
## SCREEN_SIZE_HEIGHT
SCREEN_SIZE_HEIGHT=`expr $SCREEN_SIZE_LINES + 1`
## SCREEN_SIZE_WIDTH
SCREEN_SIZE_WIDTH=`expr $SCREEN_SIZE_COLS + 1`

## SCREENSIZE_HEIGHT_HALFHEIGHT
SCREENSIZE_HEIGHT_HALFHEIGHT=0
## SCREENSIZE_WIDTH_HALFWIDTH
SCREENSIZE_WIDTH_HALFWIDTH=0

## "setScreenSizeHalfheight()" fcn
setScreenSizeHalfheight(){
  eoo=`evenOrOdd $SCREEN_SIZE_HEIGHT` # pass the screen height to "evenOrOdd" & it will return 'even' or 'odd' so we can check its return value & act accordingly
  if [ "$eoo" == "even" ] # even number / nbre pair
  then
    SCREENSIZE_HEIGHT_HALFHEIGHT=`expr $SCREEN_SIZE_HEIGHT / 2`
  elif [ "$eoo" == "odd" ] # odd number / nbre impair
  then
    tmp=`expr $SCREEN_SIZE_HEIGHT - 1`
    SCREENSIZE_HEIGHT_HALFHEIGHT=`expr $tmp / 2`
  fi
}
## "setScreenSizeHalfwidth()" fcn
setScreenSizeHalfwidth(){
  eoo=`evenOrOdd $SCREEN_SIZE_WIDTH` # pass the screen height to "evenOrOdd" & it will return 'even' or 'odd' so we can check its return value & act accordingly
  if [ "$eoo" == "even" ] # even number / nbre pair
  then
    SCREENSIZE_WIDTH_HALFWIDTH=`expr $SCREEN_SIZE_WIDTH / 2`
  elif [ "$eoo" == "odd" ] # odd number / nbre impair
  then
    tmp2=`expr $SCREEN_SIZE_WIDTH - 1`
    SCREENSIZE_WIDTH_HALFWIDTH=`expr $tmp2 / 2`
  fi
}
## "setScreenSizeHalf()" fcn
setScreenSizeHalf(){
  setScreenSizeHalfheight
  setScreenSizeHalfwidth
}
# "displayScreenSetup()" fcn
displayScreenSetup(){
  echo -e "\n      -- Current screen setup --"
  
  echo -e "\n"
  echo -e "\t SCREEN_SIZE_LINES: $SCREEN_SIZE_LINES"
  echo -e "\t SCREEN_SIZE_COLS: $SCREEN_SIZE_COLS"
  echo -e "\t SCREEN_SIZE_HEIGHT: $SCREEN_SIZE_HEIGHT"
  echo -e "\t SCREEN_SIZE_WIDTH: $SCREEN_SIZE_WIDTH"
  # check if the value holding half the screen height has already been initialized, and do so if it's not the case
  if [ $SCREENSIZE_HEIGHT_HALFHEIGHT -eq 0 ]
  then
    setScreenSizeHalfheight # initialize it
  fi
  # check if the value holding half the screen width has already been initialized, and do so if it's not the case
  if [ $SCREENSIZE_WIDTH_HALFWIDTH -eq 0 ]
  then
    setScreenSizeHalfwidth # initialize it
  fi
  echo -e "\t SCREENSIZE_HEIGHT_HALFHEIGHT: $SCREENSIZE_HEIGHT_HALFHEIGHT"
  echo -e "\t SCREENSIZE_WIDTH_HALFWIDTH: $SCREENSIZE_WIDTH_HALFWIDTH"
  echo -e "\n"
  
  # wait for user input to close the pane displaying screen infos
  #read -s -n 1 -p ÒPress any key to continueÉÓ # sleep 10 # sleep a littl' while ( we could wait for user input -> that's what we'll DO ! :D )
  #echo
  #read -p "      -- Press [Enter] key to resume --" # - work
  pause "      -- Press [Enter] key to resume --" # same as above, but using the mini-framework
  
  # clear screen & move to origin
  clearAndDrawAtOrigin_ANSI # clear the screen and move the drawer location to the origin (0,0)
}


# R: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html
#
# aka " Bash Prompt HOWTO: Chapter 6. ANSI Escape Sequences: Colours and Cursor Movement > 6.2. Cursor Movement "

## - Draw Fcns -

## "drawAt()" fcn - usage: ' drawwAt X Y ' - doesn't seems to handle Y ..
drawAt(){
  tput cup $2 $1 # tput cup Y X
}
## "drawAt_ANSI()" fcn - usage: ' drawAtANSI X Y '
drawAt_ANSI(){
  echo -en "\033[$2;$1H" # R: syntax is: ' \033[<L>;<C>H ' or ' \033[<L>;<C>f ' 
}
## "drawUp_ANSI()" fcn - usage: ' drawUpANSI X '
drawUp_ANSI(){
  echo -en "\033[$1A" # R: syntax is: ' \033[<X>A ' 
}
## "drawDown_ANSI()" fcn - usage: ' drawDownANSI X '
drawDown_ANSI(){
  echo -en "\033[$1B" # R: syntax is: ' \033[<X>B ' 
}
## "drawLeft_ANSI()" fcn - usage: ' drawLeftANSI X '
drawLeft_ANSI(){
  echo -en "\033[$1B" # R: syntax is: ' \033[<X>D ' 
}
## "drawRight_ANSI()" fcn - usage: ' drawRightANSI X '
drawRight_ANSI(){
  echo -en "\033[$1C" # R: syntax is: ' \033[<X>C ' 
}
## "clearAndDrawAtOrigin_ANSI()" fcn
clearAndDrawAtOrigin_ANSI(){
  echo -en "\033[2J"
}
## "eraseFromDrawToEOL_ANSI()" fcn
eraseFromDrawToEOL_ANSI(){
  echo -en "\033[K"
}
## "drawCenteredText()" fcn - usage: ' drawCenteredText "some text" '
drawCenteredText(){
  # make it "draw-context-safe" - seems not to work from INSIDE the current fcn ( -> so, (here), done in "setup()" )
  #saveContext # save cursor position before drawing 

  # R: get length of stuff
  #      echo "${#VAR}"
  #  or: expr length "$VAR"
  #  or: echo $VAR | awk '{print length}'
  #  or: echo -n $VAR | wc -m
  #
  
  #txt_len=`expr length "$1"`
  txt_len=`echo "${#1}"`
  #echo "text '$1'  is $txt_len characters long" # - what is nice is that I can still benefit from the console output to debug while testing ;D
  half_len=0
  
  # adjust in case we get an even number using the mini-framework "evenOrOdd()" fcn
  eoo=`evenOrOdd $txt_len` # pass the text length to "evenOrOdd" & it will return 'even' or 'odd' so we can check its return value & act accordingly
  if [ "$eoo" == "even" ] # even number / nbre pair
  then
    #echo "EOO -> $eoo !"
    #echo "txt_len is EVEN"
    half_len=`expr $txt_len / 2`
    #echo "txt_len / 2 = $half_len, and is EVEN"
  elif [ "$eoo" == "odd" ] # odd number / nbre impair
  then
    #echo "EOO -> $eoo !"
    #echo "txt_len is ODD"
    tmp=`expr $txt_len - 1`
    #echo "tmp ( aka txt_len - 1 ) = $tmp"
    half_len=`expr $tmp / 2`
    #echo "tmp / 2 = $half_len, and is EVEN"
  fi
    
  # calculate the actual positionning of the text to draw using half its length and half the screen width
  txt_pos=`expr $SCREENSIZE_WIDTH_HALFWIDTH - $half_len`
  
  # draw text at the center of the screen
  drawAt_ANSI $txt_pos $SCREENSIZE_HEIGHT_HALFHEIGHT # position the drawer to the location to draw to
  echo -ne $1 # draw the text passed as parameter
  
  # make it "draw-context-safe" - seems not to work from INSIDE the current fcn ( -> so, (here), done in "setup()" )
  #restoreContext # restore the cursor position after drawing
}

## - Background / Foreground & related Fcns -

## "setBackgroundColor()" fcn - usage: ' setBackgroundColor [1-7] '
setBackgroundColor(){
  tput setb $1
}
## "setBackgroundColor_ANSI()" fcn - usage: ' setBackgroundColor_ANSI [1-7] '
setBackgroundColor_ANSI(){
  tput setab $1
}
## "setForegroundColor()" fcn - usage: ' setForegroundColor [1-7] '
setForegroundColor(){
  tput setaf $1
}
## "setForegroundColor_ANSI()" fcn - usage: ' setForegroundColor_ANSI [1-7] '
setForegroundColor_ANSI(){
  tput setf $1
}

## - Text Configuration Fcns -

## "setTextBold()" fcn
setTextBold(){
  tput bold
}
## "setTextHalfbright()" fcn
setTextHalfbright(){
  tput dim
}
## "setTextUnderlineBegin()" fcn
setTextUnderlineBegin(){
  tput smul
}
## "setTextUnderlineEnd()" fcn
setTextUnderlineEnd(){
  tput rmul
}
## "setTextReverseMode()" fcn
setTextReverseMode(){
  tput rev
}
## "setTextStandoutModeBegin()" fcn
setTextStandoutModeBegin(){
  tput smso
}
## "setTextStandoutModeEnd()" fcn
setTextStandoutModeEnd(){
  tput rmso
}
## "setTextResetAttributes()" fcn
setTextResetAttributes(){
  tput sgr0
}

## - Context Fcns -

## "saveContext()" fcn
saveContext(){
  tput sc # save cursor location
}
## "saveContext_ANSI()" fcn
saveContext_ANSI(){
  echo -en "\033[s"
}
## "restoreContext()" fcn - 
restoreContext(){
  tput rc # restore cursor location
}
## "restoreContext_ANSI()" fcn
restoreContext_ANSI(){
  echo -en "\033[u"
}

## - Assorted helper Fcns -

## "evenOrOdd()" fcn
evenOrOdd(){
num=$1
if [ $((num%2)) -eq 0 ];
then
  echo "even";
else
  echo "odd";
fi
}

## "pause()" fcn - usage: ' pause 'Press [Enter] key to continue...' ' or ' pause "Press [Enter] key to continue..." '
pause(){
  read -p "$*"
}

## ---- actual program code ---- ##

## We "source" the file containing the "draw()" & "setup()" functions defined by the end-user ( for the moment me ;D )
source ascii_animation__project.sh # the name is currently hardcoded ( .. )

# now we have the end-user 's variables , custom functions & the necessary "setup()" & "draw()" functions, we can invoke the last two,
# respectively in the "_setup()" &  the "_draw()" functions

## "setup()" fcn
_setup(){
  # - now using the mini-framework -
  clear # clear the screen the standard way
  
  setScreenSizeHalf # init the vars that 'll hold the values of 'half the height' & 'half the width'
  
  #setTextStandoutModeBegin # change the display mode of the text displaying infos on the current terminal window size - works
  saveContext # save cursor position before drawing
  displayScreenSetup # get the current screen setup
  restoreContext # restore the cursor position after drawing
  #setTextStandoutModeEnd # - works

  #setBackgroundColor 6 # set the background color - doesn't seems to work on my terminal
  #setForegroundColor 6 - same as above
  # -> considering the above, I guess I'll have to do it the "ANSI Escape Seqences" way again ..

  #display_arrayloop # - work
  #display_arrayloop2 # - work
  #display_extarrayloop "$ab_array" - do NOT currently work :/
  
  # dummy test with fcns .. that works ! ( nice for further tests .. ;p )
  #invokerFcn callbackFcn  # pass a fcn as parameter to another function in bash
  #invokerFcn2 callbackFcn2 Stan Kenny  # pass a fcn as parameter to another function in bash, with parameters this time ( here, all parameters are passed to the callback function )
  #invokerFcn3 callbackFcn3 Stan Kenny # pass a fcn as parameter to another function in bash, as above, this time with one parameter for the invoker fcn & the other for the callback
  
  saveContext # save cursor position before drawing
  echo -en "test text .l|l."
  restoreContext # restore the cursor position after drawing
  
  sleep 2
  
  saveContext # save cursor position before drawing
  echo -en "...... and BADABOOM !!"
  restoreContext # restore the cursor position after drawing
  
  # call the user-defined "setup()" fcn
  setup
}

## "draw()" fcn
_draw(){
  for (( ; ; ))
    do
      # - now using the mini-framework -
      saveContext # save cursor position before drawing
      
      ##drawAt 5 10# go to a specified location on the screen - seems that my fcn doesn't care about the Y ..
      
      # position the drawer to the location to draw to & draw stg - works
      #drawAt_ANSI 10 10 # same as above, this time the "ANSI Escape Sequences" way ..
      #echo -en "Hello World !"
      
      #setTextBold # set the text writing parameter to bold - works
      #drawCenteredText "Hello World !" # now defined in "ascii_animation__project", inside user-defined fcn "draw()"
      #setTextResetAttributes # turn off any text mode on - ' don't know if it works ? ( 'll see using the corresponding ANSI Escape Sequences characters .. )
      
      #display_animation # display the animation before looping over it again .. and again ..
      
      # call the user-defined "draw()" fcn
      draw
      
      restoreContext # restore the cursor position after drawing
      sleep 1 # sleep 1 second before .. sleeping one second again .. -- 'd benefit from an "externally settable ~$FRAMERATE" var ( .. )
    done
}

## --
#_setup # execute the "setup()" fcn call -- now in "ascii_animation__executable"
#_draw # initiate the endless loop using the "draw()" fcn call -- "ascii_animation__executable"
## --

## ---- ASCII_ANIMATION FRAMEWORK ---- CODE END ---- ##



