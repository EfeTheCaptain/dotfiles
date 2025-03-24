#!/bin/bash

# Load Pywal colors if available
if [[ -f ~/.cache/wal/colors.bash ]]; then
    source ~/.cache/wal/colors.bash
else
    # Fallback to your original colors if Pywal isn't available
    bright_sky='\[\e[38;5;117m\]'  # Light Blue (Sunny Sky)
    mid_sky='\[\e[38;5;39m\]'     # Medium Blue (Day Sky)
    cloud_white='\[\e[38;5;231m\]' # White (Clouds)
    sunlit_leaves='\[\e[38;5;118m\]' # Light Green (Sunlit Leaves)
    evergreen_dark='\[\e[38;5;22m\]' # Dark Green (Evergreen Needles)
    mossy_green='\[\e[38;5;28m\]'     # Moss Green
    bark_brown='\[\e[38;5;94m\]'     # Bark Brown
    soil_brown='\[\e[38;5;52m\]'     # Soil Brown
    sun_yellow='\[\e[38;5;226m\]'    # Bright Yellow (Sun)
    forest_shadow='\[\e[38;5;16m\]' # Dark Grey (Shadows)
    nc='\[\e[0m\]'
fi

# Color detection logic (remains the same)
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

# Root/user prompt (use Pywal colors or fallbacks)
if [ "$UID" = 0 ]; then
    PS1="\n\[\e[1;32m\]╭━━━[\[${color1:-$bright_sky}\]\u@\h\[\e[1;32m\]]━━━[\[${color15:-$cloud_white}\]\w\[\e[1;32m\]]\n\[\e[1;32m\]╰━━▶  :\[\e[0m\] "
else
    PS1="\n\[\e[1;32m\]╭━━━[\[${color2:-$sunlit_leaves}\]\u@\h\[\e[1;32m\]]━━━[\[${color4:-$mid_sky}\]\w\[\e[1;32m\]]\n\[\e[1;32m\]╰━━▶  \[\e[0m\] "
fi

unset color_prompt force_color_prompt

# Xterm title setting (remains the same)
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# Force color interpretation (remains the same)
PS1="$(eval echo -e \"$PS1\")"
