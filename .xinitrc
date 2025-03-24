#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

xrdb -merge ~/.Xresources

# Execute set-run-user.sh
if [ -x ~/.config/system/set-run-user.sh ]; then
  ~/.config/system/set-run-user.sh
fi

wal -i ~/img/AI\ Image/
xcompmgr &
sxhkd &

# Execute dwm
exec dwm
