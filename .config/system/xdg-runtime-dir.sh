#runit service at /etc/runit/runsvdir/default/create-run-user/run
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)        # No sudo needed for export
    sudo mkdir -p "$XDG_RUNTIME_DIR"                   # Use sudo for mkdir
    sudo chmod 0700 "$XDG_RUNTIME_DIR"                 # Use sudo for chmod
    sudo chown $(id -u):$(id -g) "$XDG_RUNTIME_DIR"    # Use sudo for chown
fi
