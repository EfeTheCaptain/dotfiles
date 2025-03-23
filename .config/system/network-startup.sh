#!/bin/sh

# Configuration Variables
KEYBOARD_LAYOUT="trq"
WLAN_INTERFACE="wlan0"
WPA_CONFIG="/etc/wpa_supplicant/wpa_supplicant.conf"
DHCLIENT_TIMEOUT=20 # Increase timeout for dhclient in seconds

# Command Locations (Variables)
LOADKEYS_CMD="/usr/bin/loadkeys"
IP_CMD="/usr/sbin/ip"
WPA_SUPPLICANT_CMD="/usr/sbin/wpa_supplicant"
DHCLIENT_CMD="/usr/sbin/dhclient"

# Function to load keyboard layout
load_keyboard() {
  if command -v "$LOADKEYS_CMD" &> /dev/null; then
    "$LOADKEYS_CMD" "$KEYBOARD_LAYOUT"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to load keyboard layout '$KEYBOARD_LAYOUT'."
      return 1
    fi
    echo "Keyboard layout '$KEYBOARD_LAYOUT' loaded."
    return 0
  else
    echo "Warning: loadkeys command not found. Keyboard layout not loaded."
    return 0 # Non-critical error
  fi
}

# Function to bring up WLAN interface
bring_up_wlan() {
  if command -v "$IP_CMD" &> /dev/null; then
    "$IP_CMD" link set "$WLAN_INTERFACE" up
    if [ $? -ne 0 ]; then
      echo "Error: Failed to bring up WLAN interface '$WLAN_INTERFACE'."
      return 1
    fi
    echo "WLAN interface '$WLAN_INTERFACE' brought up."
    return 0
  else
    echo "Error: ip command not found."
    return 1
  fi
}

# Function to start wpa_supplicant
start_wpa_supplicant() {
  if command -v "$WPA_SUPPLICANT_CMD" &> /dev/null; then
    if [ -f "$WPA_CONFIG" ]; then
      "$WPA_SUPPLICANT_CMD" -B -i "$WLAN_INTERFACE" -c "$WPA_CONFIG"
      if [ $? -ne 0 ]; then
        echo "Error: Failed to start wpa_supplicant."
        return 1
      fi
      echo "wpa_supplicant started."
      return 0
    else
      echo "Error: wpa_supplicant configuration file '$WPA_CONFIG' not found."
      return 1
    fi
  else
    echo "Error: wpa_supplicant command not found."
    return 1
  fi
}

# Function to obtain IP address via DHCP
obtain_ip_address() {
  if command -v "$DHCLIENT_CMD" &> /dev/null; then
    "$DHCLIENT_CMD" -v -timeout "$DHCLIENT_TIMEOUT" "$WLAN_INTERFACE"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to obtain IP address via DHCP."
      # Add debugging information
      "$IP_CMD" a show "$WLAN_INTERFACE"
      "$IP_CMD" r show
      return 1
    fi
    echo "IP address obtained via DHCP."
    return 0
  else
    echo "Error: dhclient command not found."
    return 1
  fi
}

# Main script execution
load_keyboard
bring_up_wlan
start_wpa_supplicant
obtain_ip_address

# Exit status based on the last function's return code
exit $?
