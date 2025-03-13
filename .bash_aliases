if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat > /dev/null; then
	alias cat="batcat"
fi

alias ll='exa -T -a --level=1 --color=auto --icons'
alias lla='exa -T -a --level=2 --color=auto --icons'

alias chmodx='chmox +x'

alias ai='sudo apt install -y'
alias ar='sudo apt remove --purge'

alias nn='sudo nvim'

alias sleep='sudo pm-suspend'
alias powerof='sudo poweroff'
alias reboot='sudo reboot'

#disk usage of all the files in the given directory, sort reverse human read, top 3
#sudo du -ah /home | sort -rh | head -n 3

#ncurses disk usage
#ncdu

#search a package recommendations
#apt-cache show neovim | grep -i Recommends

###
###git commands###
#git add .
#git commit -m "commit message"
###git rever changes###
#git log
#git reset --soft def2345
###git discard broken changes###
#git checkout -- .
###


## a way to add dotfiles to github ##
# yadm init
# yadm remote add origin git@github.com:yourusername/dotfiles.git (use the ssh key)
# yadm add .bashrc .bash_aliases
# yadm commit -m "initial commit message"
# yadm branch -M main (rename the branch to main)
# yadm push -u origin main
##

