#!/bin/bash

# Color Variables
line_color='\[\e[38;5;051m\]' # Bright Cyan (Corrected!)
pkg_count='\[\e[38;5;055m\]'   # Dark Grey-Blue
cpu_model_color='\[\e[38;5;033m\]' # Deep Blue
os_logo_color='\[\e[38;5;088m\]' # Deep Red (Debian Logo)
user_color='\[\e[38;5;190m\]' # Light Yellow-Green
host_color='\[\e[38;5;022m\]' # Dark Green
dir_color='\[\e[38;5;033m\]' # Deep Blue
nc='\[\e[0m\]' # Reset

# CPU Model (Hardcoded)
cpu_model="${cpu_model_color}Intel-Atom-N550${nc}"

# Package Count (using 'dpkg' for Debian/Ubuntu-based systems)
package_count="${pkg_count}$(dpkg -l | grep '^ii' | wc -l)${nc}"

# OS Logo (Debian logo unicode character)
os_logo="${os_logo_color}󰣇${nc}"

# Define the Prompt
PS1="\n${line_color}╭─${nc}[${package_count}]\n\
${line_color}├──${nc}[${cpu_model}]\n\
${line_color}├───${nc}[ ${os_logo} ]───[${user_color}\u${nc}@${host_color}\h${nc}]───[${dir_color}\w${nc}]\n\
${line_color}╰─▶${nc} "
