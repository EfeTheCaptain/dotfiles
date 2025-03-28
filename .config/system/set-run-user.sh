#!/bin/sh
# Essential for $XDG_RUNTIME_DIR on runit.
USER_ID=$(id -u)
GROUP_ID=$(id -g)
RUNTIME_DIR="/run/user/$USER_ID"
ERROR_LOG="$HOME/set_run_user_errors"

# Sleep for a while to allow the system to initialize.
sleep 3

# Function to log errors
log_error() {
    echo "$(date) - $1" >> "$ERROR_LOG"
}

# Check if the runtime directory exists silently
if [ -d "$RUNTIME_DIR" ]; then
    # Check if it's owned by root silently
    if [ "$(stat -c %U "$RUNTIME_DIR")" = "root" ]; then
        # Change ownership and permissions silently
        sudo chmod 0700 "$RUNTIME_DIR"
        if [ $? -ne 0 ]; then
            log_error "Error setting permissions for: $RUNTIME_DIR"
            exit 1
        fi
        sudo chown "$USER_ID:$GROUP_ID" "$RUNTIME_DIR"
        if [ $? -ne 0 ]; then
            log_error "Error setting ownership for: $RUNTIME_DIR"
            exit 1
        fi
    fi
else
    # Create the runtime directory silently
    sudo mkdir -p "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        log_error "Error creating runtime directory: $RUNTIME_DIR"
        exit 1
    fi
    # Set ownership and permissions silently
    sudo chmod 0700 "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        log_error "Error setting permissions for: $RUNTIME_DIR"
        exit 1
    fi
    sudo chown "$USER_ID:$GROUP_ID" "$RUNTIME_DIR"
    if [ $? -ne 0 ]; then
        log_error "Error setting ownership for: $RUNTIME_DIR"
        exit 1
    fi
fi

# Set the XDG_RUNTIME_DIR environment variable
export XDG_RUNTIME_DIR="$RUNTIME_DIR"

# Start dbus if not already running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
    if [ $? -ne 0 ]; then
        log_error "Failed to launch dbus."
        exit 1
    fi
fi

# Additional setup steps can be placed here if needed
