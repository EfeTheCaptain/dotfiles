#!/bin/bash

# Color Variables (raw escape codes, no \[ \])
color_084='\033[38;5;084m'
color_005='\033[38;5;005m'
color_087='\033[38;5;087m'
color_231='\033[38;5;231m'
color_184='\033[38;5;184m'
color_114='\033[38;5;114m'
color_045='\033[38;5;045m'
nc='\033[0m'

# Static Info
cpu_model="${color_087}Intel-Atom-N550${nc}"
package_count="${color_005}$(dpkg -l | grep -c '^ii')${nc}"
os_logo="${color_231}\Uf0238${nc}"  # Using Unicode escape for Debian logo

# Print static header (correctly formatted)
echo -e "\n${color_084}╭──[ ${package_count} ]───[ ${os_logo} ]${nc}"
echo -e "${color_084}╰───[ ${cpu_model} ]${nc}\n"

# Define PS1 (with \[ \] for prompt safety)
PS1="\n\[\033[38;5;084m\]╭───[\[\033[38;5;184m\]\u\[\033[38;5;114m\]@\h\[\033[38;5;084m\]]──[\[\033[38;5;045m\]\w\[\033[38;5;084m\]]\n\[\033[38;5;084m\]╰─🠞 \[\033[0m\] "
