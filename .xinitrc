#!/bin/sh

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

# Execute dwm
exec dwm
