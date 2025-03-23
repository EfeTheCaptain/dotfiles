#!/bin/sh

# Determine the runtime directory
RUNTIME_DIR="/run/user/$(id -u)"

# Check if XDG_RUNTIME_DIR is not set
if [ -z "$XDG_RUNTIME_DIR" ]; then
    # Set XDG_RUNTIME_DIR
    export XDG_RUNTIME_DIR="$RUNTIME_DIR"

    # Ensure the runtime directory exists with correct permissions
    if [ ! -d "$RUNTIME_DIR" ]; then
        mkdir -p "$RUNTIME_DIR"
        chmod 700 "$RUNTIME_DIR"
        chown $(id -u):$(id -g) "$RUNTIME_DIR"
    fi
fi


exec dwm
