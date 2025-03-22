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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}'$sunlit_leaves'\u'@$evergreen_dark'\h'$nc':\[\e[1;37m\]\w'$nc'\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# Root/user prompt
if [ "$UID" = 0 ]; then
    PS1="$evergreen_dark\u$nc@$evergreen_dark\H$nc:$bright_sky\w$nc\\n$evergreen_dark#$nc "
else
    PS1="$sunlit_leaves\u$nc@$evergreen_dark\H$nc:$cloud_white\w$nc\\n$sunlit_leaves\$ $nc"
fi

# Force color interpretation
PS1="$(eval echo -e \"$PS1\")"
