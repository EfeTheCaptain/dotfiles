#!/bin/sh

# Configuration Variables
KEYBOARD_LAYOUT="trq"
WLAN_INTERFACE="wlan0"
WPA_CONFIG="/etc/wpa_supplicant/wpa_supplicant.conf"
DHCLIENT_TIMEOUT=15 # Timeout for dhclient in seconds

# Function to load keyboard layout
load_keyboard() {
  if command -v loadkeys &> /dev/null; then
    /usr/bin/loadkeys "$KEYBOARD_LAYOUT"
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
  if command -v ip &> /dev/null; then
    /usr/sbin/ip link set "$WLAN_INTERFACE" up
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
  if command -v wpa_supplicant &> /dev/null; then
    if [ -f "$WPA_CONFIG" ]; then
      /usr/sbin/wpa_supplicant -B -i "$WLAN_INTERFACE" -c "$WPA_CONFIG"
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
  if command -v dhclient &> /dev/null; then
    /usr/sbin/dhclient -timeout "$DHCLIENT_TIMEOUT" "$WLAN_INTERFACE"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to obtain IP address via DHCP."
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
