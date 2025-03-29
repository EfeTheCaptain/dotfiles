#!/bin/bash

# CPU Model (Hardcoded, as preference)
cpu_model="Intel-Atom-N550"
# Package Count Debian/Ubuntu
package_count=$(dpkg -l | grep '^ii' | wc -l)
os_logo="󰣚"

# Define the simplified prompt
PS1="\n╭──[$cpu_model]─[$package_count] \n\
├[\u@\h]─[\w]\n\
╰─[$os_logo]──▶  "
