#!/bin/sh

# Configuration Variables
KEYBOARD_LAYOUT="trq"
WLAN_INTERFACE="wlan0"
WPA_CONFIG="/etc/wpa_supplicant/wpa_supplicant.conf"

# Load keyboard layout
if command -v /usr/bin/loadkeys &> /dev/null; then
  /usr/bin/loadkeys "$KEYBOARD_LAYOUT"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to load keyboard layout '$KEYBOARD_LAYOUT'."
  fi
else
  echo "Warning: loadkeys command not found. Keyboard layout not loaded."
fi

# Check if network is already configured
if ip a show "$WLAN_INTERFACE" | grep -q "inet "; then
  echo "Network already configured. Exiting."
  exit 0
fi

# Bring wlan0 interface up
/usr/sbin/ip link set "$WLAN_INTERFACE" up

# Start wpa_supplicant in the background
/usr/sbin/wpa_supplicant -B -i "$WLAN_INTERFACE" -c "$WPA_CONFIG"

# Obtain IP address via DHCP
/usr/sbin/dhclient "$WLAN_INTERFACE"

# Exit script
