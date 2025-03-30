#!/bin/bash

# Color Variables
color_083='\[\e[38;5;083m\]' # Bright Greenish Cyan
color_005='\[\e[38;5;005m\]' # Dark Purple
color_024='\[\e[38;5;024m\]' # Light Cyan
color_231='\[\e[38;5;231m\]' # White
color_184='\[\e[38;5;184m\]' # Yellow-Green
color_076='\[\e[38;5;076m\]' # Light Green
color_045='\[\e[38;5;045m\]' # Aqua Blue
nc='\[\e[0m\]' # Reset

# CPU Model (Hardcoded)
cpu_model="${color_024}Intel-Atom-N550${nc}"

# Package Count
package_count="${color_005}$(dpkg -l | grep '^ii' | wc -l)${nc}"

# OS Logo (Debian logo unicode character)
os_logo="${color_231}󰣇${nc}"

echo -e "\n${color_084}┏━${color_084}[${package_count}${color_084}]━━[${os_logo}${color_084}]\n\
echo -e "${color_084}┣━━${color_084}[${cpu_model}${color_084}]\n\
PS1="${color_084}┣━━━[${color_184}\u${color_114}@\h${color_084}]━━━[${color_045}\w${color_084}]\n\
${color_084}┗━🠊 ${nc} "
