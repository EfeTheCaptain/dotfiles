#!/bin/bash

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

# Source color definitions
source ~/.config/bash/colors.sh

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
