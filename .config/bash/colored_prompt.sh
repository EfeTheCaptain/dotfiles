#!/bin/bash

# Dynamic content generation (with PS1 escapes)
package_count="\[\033[38;5;125m\]$(dpkg -l | grep -c '^ii')\[\033[0m\]"
cpu_model="\[\033[38;5;89m\]Intel-Atom-N550\[\033[0m\]"
os_logo="\[\033[38;5;231m\]\Uf0238\[\033[0m\]"  # White Debian logo

# Static header display (using printf for reliability)
printf "\n\033[38;5;34m╭──[ %b ]───[ %b ]\033[0m\n" "$package_count" "$os_logo"
printf "\033[38;5;34m╰───[ %b ]\033[0m\n\n" "$cpu_model"

# Interactive prompt (with proper \[ \] escaping)
PS1="\n\
\[\033[38;5;34m\]╭───[\[\033[38;5;220m\]\u\[\033[38;5;26m\]@\h\[\033[38;5;34m\]]──[\[\033[38;5;45m\]\w\[\033[38;5;34m\]]\n\
\[\033[38;5;34m\]╰─🠞 \[\033[0m\] "
