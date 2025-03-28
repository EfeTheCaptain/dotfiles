#!/bin/sh

# Execute set-run-user.sh to set up runtime directory and DBus
if [ -x "$HOME/.config/system/set-run-user.sh" ]; then
    "$HOME/.config/system/set-run-user.sh"
fi

# Source environment variables from ~/.env
if [ -f ~/.env ]; then
  . ~/.env
fi

# Check if DBUS_SESSION_BUS_ADDRESS is set
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    echo "DBUS_SESSION_BUS_ADDRESS is not set. DBus may not be running."
else
    echo "DBUS_SESSION_BUS_ADDRESS is set: $DBUS_SESSION_BUS_ADDRESS"
fi
sudo /usr/bin/loadkeys tr
xrdb -merge ~/.Xresources
dwmblocks &
xcompmgr &
sxhkd &
feh --bg-fill --random /home/efe/img/AI_Images/* &
exec dwm
