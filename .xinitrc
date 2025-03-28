#!/bin/sh
## Execute set-run-user.sh
if [ -x "$HOME/.config/system/set-run-user.sh" ]; then
  "$HOME/.config/system/set-run-user.sh"
fi 

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

sudo /usr/bin/loadkeys tr
xrdb -merge ~/.Xresources
dwmblocks &
xcompmgr &
sxhkd &
feh --bg-fill --random /home/efe/img/AI_Images/* &
exec dwm
