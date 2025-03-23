#!/bin/sh

# Disable Bluetooth
rfkill block bluetooth

# Disable all wired ethernet interfaces
for iface in /sys/class/net/eth*; do
  iface_name=$(basename "$iface")
  sudo ip link set "$iface_name" down
done
