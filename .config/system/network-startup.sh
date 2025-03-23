#!/bin/sh

# Configuration Variables
WLAN_INTERFACE="wlan0"
WPA_CONFIG="/etc/wpa_supplicant/wpa_supplicant.conf"

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
