#!/bin/sh
#WPA_SUPPLICANT 
#Bring the device up, start, get ip, ready.

# Configuration Variables
# Set runit to chmodx executable and chmod 755 to make it activate.
# add this script in it.
WLAN_INTERFACE="wlan0"
WPA_CONFIG="/etc/wpa_supplicant/wpa_supplicant.conf"

# Check if network is already configured
if sudo /usr/sbin/ip a show "$WLAN_INTERFACE" | grep -q "inet "; then
  echo "Network already configured. Exiting."
  exit 0
fi

# Bring wlan0 interface up
sudo usr/sbin/ip link set "$WLAN_INTERFACE" up

# Start wpa_supplicant in the background
sudo /usr/sbin/wpa_supplicant -B -i "$WLAN_INTERFACE" -c "$WPA_CONFIG"

# Obtain IP address via DHCP
sudo /usr/sbin/dhclient "$WLAN_INTERFACE"
echo "-----------------!--NETWORK--!-----------------"
# Exit script
