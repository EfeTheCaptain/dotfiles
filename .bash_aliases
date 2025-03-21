if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat > /dev/null; then
	alias cat="batcat"
fi
alias mk='sudo make clean install'
alias mountt='sudo /home/efe/.local/bin/automount.sh'

alias lsa='exa -a --color=auto --icons'
alias ll='exa -T -a --level=1 --color=auto --icons'
alias lla='exa -T -a --level=2 --color=auto --icons'

alias chmodx='chmox +x'

alias au='sudo nala update'
alias ai='sudo nala install'
alias ar='sudo nala remove --purge'

alias v='sudo nvim'

alias sleep='sudo pm-suspend-hybrid'
alias poff='sudo poweroff'
alias reboot='sudo reboot'

alias chmodx='sudo chmod +x'

alias wgeti='wget -N --header="Cache-Control: no-cache" --header="Pragma: no-cache" '
alias brii='brightnessctl -d intel_backlight s'

alias aliass='sudo nvim ~/.bash_aliases'
alias bashrcc='sudo nvim ~/.bashrc'

alias mygitraw='echo "https://raw.githubusercontent.com/EfeTheCaptain/"'
#disk usage of all the files in the given directory, sort reverse human read, top 3
#sudo du -ah /home | sort -rh | head -n 3

#ncurses disk usage
#ncdu

#search a package recommendations
#apt-cache show neovim | grep -i Recommends

###
###git commands###
#git status
alias gs='git status'
#git add .
#git add (filename)
alias ga='git add'
#git commit -m "commit message"
alias gc='git commit -m'
#change branch master main, if applicable
alias gm='git branch -m master main'
#git first push 'gra enter url'
alias gra='git remote add origin'
#git push
alias gpush='git push -u origin main'
alias gpull='git pull origin main'
###
#after update or make change
# git add .
# git commit -m "message"
# git push origin main
###git revert changes###
#git log
alias gl='git log --oneline --graph --decorate'
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
#
# for a second push:
# yadm log
# yadm status
# yadm add .bashrc
# yadm commit -m "message"
# (must be run at least once after the first initialization): yadm push -u origin main
# yadm branch -vv # to verify
# from now on: yadm push
##
# yadm branch -vv # to verify
# from now on: yadm push
##
# yadm branch -vv # to verify
# from now on: yadm push
##


