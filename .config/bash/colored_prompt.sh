#!/bin/bash

# Color Variables (updated with your colors)
color_084='\e[38;5;084m'  # Note: Removed \[ \] for non-PS1 use
color_005='\e[38;5;005m'
color_087='\e[38;5;087m'
color_231='\e[38;5;231m'
color_184='\e[38;5;184m'
color_114='\e[38;5;114m'
color_045='\e[38;5;045m'
nc='\e[0m'

# Static Info
cpu_model="${color_087}Intel-Atom-N550${nc}"
os_logo="${color_231}󰣇${nc}"
package_count="${color_005}$(dpkg -l | grep -c '^ii')${nc}"

# Print static header (using printf for reliable Unicode)
printf "\n${color_084}╭──[ %s ]───[ %s ]${nc}\n" "$package_count" "$os_logo"
printf "${color_084}╰───[ %s ]${nc}\n\n" "$cpu_model"

# Define PS1 (restore \[ \] for prompt safety)
color_084_ps1='\[\e[38;5;084m\]'  # PS1 needs \[ \] for cursor position
color_184_ps1='\[\e[38;5;184m\]'
color_114_ps1='\[\e[38;5;114m\]'
color_045_ps1='\[\e[38;5;045m\]'
nc_ps1='\[\e[0m\]'

PS1="${color_084_ps1}╭───[${color_184_ps1}\u${color_114_ps1}@\h${color_084_ps1}]──[${color_045_ps1}\w${color_084_ps1}]\n${color_084_ps1}╰─🠞 ${nc_ps1} "
