#!/bin/sh

## Execute set-run-user.sh to ensure $XDG_RUNTIME_DIR exists
if [ -x "$HOME/.config/system/set-run-user.sh" ]; then
  "$HOME/.config/system/set-run-user.sh"
fi 

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

## If DBUS_SESSION_BUS_ADDRESS is not set, start a DBus session:
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi
#
## Ensure DISPLAY is updated in DBus activation environment:
dbus-update-activation-environment DISPLAY

# Other startup commands:
xrdb -merge ~/.Xresources
dwmblocks &
xcompmgr &
sxhkd &
feh --bg-fill --random /home/efe/img/AI_Images/* &

# Start the window manager
exec dwm
