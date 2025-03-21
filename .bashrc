# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

###
 # set a fancy prompt (non-color, unless we know we "want" color)
 # Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt if the terminal has the capability
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Define color codes using 256 colors based on the hex values you provided
light_beige='\[\e[38;5;230m\]'     # #D0CFC4
olive_green='\[\e[38;5;142m\]'      # #919E3F
dark_olive_green='\[\e[38;5;136m\]' # #717C2A
dark_green='\[\e[38;5;58m\]'        # #4B6826
almost_black='\[\e[38;5;235m\]'     # #0F100D
deep_green='\[\e[38;5;22m\]'        # #2A401C
dark_olive='\[\e[38;5;59m\]'         # #434C16
greyish_teal='\[\e[38;5;236m\]'      # #334B48
greyish_green='\[\e[38;5;240m\]'     # #717F7F
golden_brown='\[\e[38;5;178m\]'      # #AC6C04
nc='\[\e[0m\]'                       # No color

# Set prompt based on user and color preference
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}'$olive_green'\u'@$dark_olive_green'\h'$nc':\[\e[1;37m\]\w'$nc'\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Reset to no color
nc='\[\e[0m\]'

if [ "$UID" = 0 ]; then
    PS1="$dark_green\u$nc@$dark_green\H$nc:$blue\w$nc\\n$dark_green#$nc "
else
    PS1="$olive_green\u$nc@$dark_olive_green\H$nc:$light_beige\w$nc\\n$olive_green\$ $nc"
fi 

###
print_color_squares() {
    # Define colors in an array
    local colors=(
        '\e[48;5;230m'  # Light Beige
        '\e[48;5;142m'  # Olive Green
        '\e[48;5;136m'  # Dark Olive Green
        '\e[48;5;58m'   # Dark Green
        '\e[48;5;235m'  # Almost Black
        '\e[48;5;22m'   # Deep Green
        '\e[48;5;59m'   # Dark Olive
        '\e[48;5;236m'  # Greyish Teal
        '\e[48;5;240m'  # Greyish Green
        '\e[48;5;178m'  # Golden Brown
    )
    
    # Predefined reset code
    local reset='\e[0m'
    
    # Prepare output buffer
    local output=""

    # Build the output in one go (each block is 2 spaces wide)
    for color in "${colors[@]}"; do
        output+="${color}  ${reset}"  # Each block of color with no character
    done

    # Print all colored blocks at once
    printf "$output\n"
}

# Call the function to display the squares
###


#You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Created by `pipx` on 2025-03-17 21:39:20
export PATH="$PATH:/home/efe/.local/bin"
eval "$(zoxide init bash)"

afetch
print_color_squares


