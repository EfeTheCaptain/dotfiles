#!/bin/bash

# Color Variables
line_color='\[\e[38;5;083m\]'  # Bright Greenish Cyan (for all lines and brackets)
pkg_count='\[\e[38;5;005m\]'   # Dark Purple
cpu_model_color='\[\e[38;5;087m\]' # Light Cyan
os_logo_color='\[\e[38;5;231m\]' # White (Debian logo)
user_color='\[\e[38;5;184m\]' # Yellow-Green
host_color='\[\e[38;5;076m\]' # Light Green
dir_color='\[\e[38;5;045m\]' # Aqua Blue
nc='\[\e[0m\]' # Reset

# CPU Model (Hardcoded)
cpu_model="${cpu_model_color}Intel-Atom-N550${nc}"

# Package Count
package_count="${pkg_count}$(dpkg -l | grep '^ii' | wc -l)${nc}"

# OS Logo (Debian logo unicode character)
os_logo="${os_logo_color}󰣇${nc}"

# Define the Prompt
PS1="\n${line_color}╭─${line_color}[${package_count}]${nc}\n\
${line_color}├──${line_color}[${cpu_model}]${nc}\n\
${line_color}├───${line_color}[ ${os_logo} ]───${line_color}[${user_color}\u${nc}@${host_color}\h${nc}]───${line_color}[${dir_color}\w${nc}]\n\
${line_color}╰─▶${nc} "
