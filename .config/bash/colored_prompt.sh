#!/bin/bash

# Color Variables (updated with your colors)
color_084='\[\e[38;5;084m\]'  # Your Greenish-Cyan (replaces 083)
color_005='\[\e[38;5;005m\]'  # Dark Purple (package count)
color_087='\[\e[38;5;087m\]'  # Light Cyan (CPU model)
color_231='\[\e[38;5;231m\]'  # White (OS logo)
color_184='\[\e[38;5;184m\]'  # Yellow-Green (username)
color_114='\[\e[38;5;114m\]'  # Light Green (hostname, replaces 076)
color_045='\[\e[38;5;045m\]'  # Aqua Blue (directory)
nc='\[\e[0m\]'                # Reset

# Static Info (cached at startup)
cpu_model="${color_087}Intel-Atom-N550${nc}"
os_logo="${color_231}󰣇${nc}"

# Function to get package count (cached)
update_pkg_count() {
  echo "${color_005}$(dpkg -l | grep -c '^ii')${nc}" > ~/.pkg_count_cache
}
# Initialize cache (run once)
[[ ! -f ~/.pkg_count_cache ]] && update_pkg_count

# Print static header ONCE per terminal session
echo -e "\n${color_084}╭──[ $(<~/.pkg_count_cache) ]───[ ${os_logo} ]${nc}"
echo -e "${color_084}╰───[ ${cpu_model} ]${nc}\n"

# Dynamic PS1 (fast, no subshells)
PS1="${color_084}╭───[${color_184}\u${color_114}@\h${color_084}]──[${color_045}\w${color_084}]\n${color_084}╰─🠞 ${nc} "

# Optional: Update package count every 30 mins (silently)
PROMPT_COMMAND='(( ++PROMPT_COUNT % 1800 == 0 )) && update_pkg_count &'
