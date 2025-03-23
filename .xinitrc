#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi
sxhkd &
# Execute dwm
exec dwm
