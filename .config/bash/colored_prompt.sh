#!/bin/bash

# Define color variables
COL_GREEN="\033[38;5;34m"
COL_BLUE="\033[38;5;125m"
COL_CYAN="\033[38;5;89m"
COL_YELLOW="\033[38;5;220m"
COL_RED="\033[38;5;45m"

# Dynamic content generation (with PS1 escapes)
package_count="${COL_BLUE}$(dpkg -l | grep -c '^ii')"
cpu_model="${COL_CYAN}Intel-Atom-N550"
os_logo="\U238" 

# Static header display (using printf for reliability)
printf "${COL_GREEN}╭──[ %b ${COL_GREEN}]───[ %b ${COL_GREEN}]\n" "$package_count" "$os_logo"
printf "${COL_GREEN}╰───[ %b ${COL_GREEN}]" "$cpu_model"

# Interactive prompt (with proper \[ \] escaping)
PS1="\n\
\[\033[38;5;34m\]╭───[\[\033[38;5;220m\]\u\[\033[38;5;24m\]@\h\[\033[38;5;34m\]]──[\[\033[38;5;45m\]\w\[\033[38;5;34m\]]\n\
\[\033[38;5;34m\]╰─🠞 "
