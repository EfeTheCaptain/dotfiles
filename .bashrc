[ -z "$PS1" ] && return

# Call the color prompt file
source ~/.config/bash/colored_prompt.sh

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# Key bindings
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

###
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
###
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
###
# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

#in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc
#remove the urgent part from the pywal cache
#sed -i '17s/^/\/\//' /home/efe/.cache/wal/colors-wal-dwm.h

test -r ~/.config/bash/.dir_colors && eval $(dircolors ~/.config/bash/.dir_colors)

# Source .env for environment variables
if [ -f ~/.env ]; then
    . ~/.env
fi

. "$HOME/.cargo/env" 
afetch
eval "$(zoxide init bash)"

hstr --show-configuration >> ~/.bashrc
