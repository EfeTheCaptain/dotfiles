#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

xrdb -merge ~/.Xresources

xcompmgr &
sxhkd &
feh --bg-fill --random /home/efe/img/AI_Images/* &
# Execute dwm
exec dwm
