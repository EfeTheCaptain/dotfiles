#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

# Execute set-run-user.sh
if [ -x ~/.config/system/set-run-user.sh ]; then
  ~/.config/system/set-run-user.sh
fi

sxhkd &

# Execute dwm
exec dwm
