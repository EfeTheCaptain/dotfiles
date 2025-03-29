#!/bin/bash

# Color Variables
color_083='\[\e[38;5;083m\]' # Bright Greenish Cyan
color_005='\[\e[38;5;005m\]' # Dark Purple
color_087='\[\e[38;5;087m\]' # Light Cyan
color_231='\[\e[38;5;231m\]' # White
color_184='\[\e[38;5;184m\]' # Yellow-Green
color_076='\[\e[38;5;076m\]' # Light Green
color_045='\[\e[38;5;045m\]' # Aqua Blue
nc='\[\e[0m\]' # Reset

# CPU Model (Hardcoded)
cpu_model="${color_087}Intel-Atom-N550${nc}"

# Package Count
package_count="${color_005}$(dpkg -l | grep '^ii' | wc -l)${nc}"

# OS Logo (Debian logo unicode character)
os_logo="${color_231}󰣇${nc}"

# Define the Prompt
PS1="\n${color_083}╭─${color_083}[${package_count}]${color_083}─[${os_logo}]${nc}\n\
${color_083}├──${color_083}[${cpu_model}]${nc}\n\
${color_083}├───[${color_184}\u${nc}@${color_076}\h${nc}]───[${color_045}\w]${color_083}\n\
${color_083}╰─▶${nc} "
