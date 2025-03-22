#!/bin/bash

# Define Sunny Evergreen Forest with Sky Palette
bright_sky='\[\e[38;5;117m\]'  # Light Blue (Sunny Sky)
mid_sky='\[\e[38;5;39m\]'    # Medium Blue (Day Sky)
cloud_white='\[\e[38;5;231m\]' # White (Clouds)
sunlit_leaves='\[\e[38;5;118m\]' # Light Green (Sunlit Leaves)
evergreen_dark='\[\e[38;5;22m\]' # Dark Green (Evergreen Needles)
mossy_green='\[\e[38;5;28m\]'    # Moss Green
bark_brown='\[\e[38;5;94m\]'    # Bark Brown
soil_brown='\[\e[38;5;52m\]'    # Soil Brown
sun_yellow='\[\e[38;5;226m\]'   # Bright Yellow (Sun)
forest_shadow='\[\e[38;5;16m\]' # Dark Grey (Shadows)
nc='\[\e[0m\]'

# Color detection logic
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Root/user prompt
if [ "$UID" = 0 ]; then
    PS1="\n\[\e[1;32m\]╭━━━[\[$bright_sky\]\u@\h\[\e[1;32m\]]━━━[\[$cloud_white\]\w\[\e[1;32m\]]\n\[\e[1;32m\]╰━━➜\[\e[0m\] "
else
    PS1="\n\[\e[1;32m\]╭━━━[\[$sunlit_leaves\]\u@\h\[\e[1;32m\]]━━━[\[$mid_sky\]\w\[\e[1;32m\]]\n\[\e[1;32m\]╰━━➜\[\e[0m\] "
fi

unset color_prompt force_color_prompt

# Xterm title setting
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# Force color interpretation
PS1="$(eval echo -e \"$PS1\")"
