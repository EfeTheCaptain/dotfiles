# .bash_profile

# Source .bashrc
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Load Turkish Q keyboard layout
sudo /usr/bin/loadkeys trq

# Set initial backlight brightness
brightnessctl -d intel_backlight s 10%

# Execute network-startup.sh
if [ -x "$HOME/.config/system/network-startup.sh" ]; then
    "$HOME/.config/system/network-startup.sh"
fi

# Disable bluetooth and ethernet on login
if [ -x "$HOME/.config/system/eth-blue-disable.sh" ]; then
    "$HOME/.config/system/eth-blue-disable.sh"
fi

# Execute set-run-user.sh
if [ -x "$HOME/.config/system/set-run-user.sh" ]; then
  "$HOME/.config/system/set-run-user.sh"
fi

# Source ~/.profile (if it exists)
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi
