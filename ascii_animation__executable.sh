#!/bin/bash
# the above is not actually necessary for me, except of a cleaner debugging / coding ( .. )

####
## -- ASCII_ANIMATION FRAMEWORK --
##
##    Game / Project executable
##
##       <GAME/PROJECT NAME>
##       <GAME/PROJECT TYPE>
##       <GAME/PROJECT INFO>
##      <GAME/PROJECT AUTHOR>
##       <GAME/PROJECT MAIL>
##       <GAME/PROJECT WWW.> 
####

## --
# Import the [tiny & wip] Ascii Animation Framework
source ascii_animation__framework.sh # -- ! MUST BE PRESENT
# Init & launch game/project
_setup # -- ! MUST BE PRESENT
_draw # -- ! MUST BE PRESENT
## --