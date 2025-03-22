#!/bin/sh

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
	eval $(dbus-launch --sh-syntax) || echo "DBUS FAILED !!!"
fi

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=run/user/$(id -u)
	sudo mkdir -p "$XDG_RUNTIME_DIR" 
	sudo chmod 0700 "$XDG_RUNTIME_DIR" 
	sudo chown $(id -u):$(id -g) "XDG_RUNTIME_DIR"
fi


exec dwm
