if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat > /dev/null; then
	alias cat="batcat"
fi

alias cp='cp -vi'
alias mv='mv -vi'
alias count="ls * | wc -l"
alias cpv='rsync -avh --info=progress2'

alias mk='sudo make clean install'
alias mountt='sudo /home/efe/.local/bin/mountfzf.sh'

alias lsa='exa -a --color=auto --icons'
alias ll='exa -T -a --level=1 --color=auto --icons'
alias lla='exa -T -a --level=2 --color=auto --icons'

alias au='sudo apt update'
alias ai='sudo apt install'
alias ar='sudo apt remove --purge'

alias v='sudo nvim'

alias sleep='sudo pm-suspend-hybrid'
alias poff='sudo poweroff'
alias reboot='sudo reboot'

alias chmodx='sudo chmod +x'

alias wgeti='wget -N --header="Cache-Control: no-cache" --header="Pragma: no-cache" '
#alias brii='brightnessctl -d intel_backlight s'

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
#git add -A
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
# 1️⃣ Initialize YADM (if not already)
# yadm init --path $HOME

# 2️⃣ Check current status and make sure you're on the correct branch
# yadm status

# 3️⃣ If you need to create the 'locali' branch or switch:
# yadm checkout -b locali

# 4️⃣ Add files (e.g., new file) to your yadm-managed dotfiles
# yadm add <file_name>

# 5️⃣ Commit your changes
# yadm commit -m "Add new file or update"

# 6️⃣ Set upstream for the 'locali' branch to track remote
# yadm push --set-upstream origin locali

# 7️⃣ Push changes to remote (GitHub)
# yadm push

# 8️⃣ If you need to remove 'main' branch locally and remote (optional):
# yadm branch -dr origin/main  # Remove local tracking reference
# yadm remote prune origin     # Clean up remote refs
# yadm push origin --delete main  # Remove from GitHub (optional)

# 9️⃣ Verify everything is in sync:
# yadm branch -a               # Check local and remote branches
# yadm status                  # Verify no further changes to push

#alias yadm-force-push='yadm fetch origin && yadm reset --hard origin/$(yadm symbolic-ref --short HEAD) && yadm push --force'
#alias yadm-force-pull='yadm fetch origin && yadm reset --hard origin/$(yadm symbolic-ref --short HEAD)'
alias ya='yadm add .bashrc .bash_profile .bash_aliases .env .profile .xinitrc .xprofile .Xresources ~/.config/bash* ~/.config/sxhkd/* ~/.config/system/*'
alias yc='yadm commit -m'


#### APPS TO REMEMBER ###
# add-apt-repository
# acpi (battery-power)
# fim img.jpg (terminal based image viewer)
# xcompmgr (compositor, necessary for alpha patches)
# scrot (screen capture)
