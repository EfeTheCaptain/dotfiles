#!/bin/sh
#essential for $XDG_RUNTIME_DIR on runit.#
USER_ID=1000
GROUP_ID=1000
RUNTIME_DIR="/run/user/$USER_ID"

# Check if the runtime directory exists
if [ -d "$RUNTIME_DIR" ]; then
    # Check if it's owned by root
    if [ "$(sudo stat -c %U "$RUNTIME_DIR")" = "root" ]; then
        # Change ownership and permissions
        sudo chmod 0700 "$RUNTIME_DIR"
        if [ $? -ne 0 ]; then
            echo "Error setting permissions for: $RUNTIME_DIR"
            exit 1
        fi
        sudo chown "$USER_ID:$GROUP_ID" "$RUNTIME_DIR"
        if [ $? -ne 0 ]; then
            echo "Error setting ownership for: $RUNTIME_DIR"
            exit 1
        fi
    fi
else
    # Create the runtime directory
    sudo mkdir -p "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        echo "Error creating runtime directory: $RUNTIME_DIR"
        exit 1
    fi
    # Set ownership and permissions
    sudo chmod 0700 "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        echo "Error setting permissions for: $RUNTIME_DIR"
        exit 1
    fi
    sudo chown "$USER_ID:$GROUP_ID" "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        echo "Error setting ownership for: $RUNTIME_DIR"
        exit 1
    fi
fi

# Service exits after completing its task
