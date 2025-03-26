#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi
# Execute set-run-user.sh
if [ -x "$HOME/.config/system/set-run-user.sh" ]; then
  "$HOME/.config/system/set-run-user.sh"
fi

xrdb -merge ~/.Xresources

xcompmgr &
sxhkd &
feh --bg-fill --random /home/efe/img/AI_Images/* &
# Execute dwm
exec dwm
