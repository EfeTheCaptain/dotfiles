#!/bin/bash

# CPU Model (Hardcoded, as per your preference)
cpu_model="Intel-Atom-N550"

# Package Count (using 'dpkg' for Debian/Ubuntu-based systems)
package_count=$(dpkg -l | grep '^ii' | wc -l)

# Define the simplified prompt
PS1="\n╭──[$cpu_model]─[$package_count] \n\
├[\u@\h]─[\w]\n\
╰─[]──▶  "
