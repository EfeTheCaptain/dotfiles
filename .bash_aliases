if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat > /dev/null; then
	alias cat="batcat"
fi

alias cp='cp -vi'
alias mv='mv -vi'
alias count="exa * | wc -l"
alias cpv='rsync -avh --info=progress2'

alias mk='doas make clean install'
alias mountt='sudo /home/efe/.local/bin/scripts/mountfzf.sh'
alias ytaudio='. ~/yt-audio'
alias lsa='exa -a --color=auto --icons'
alias ll='exa -T -a --level=1 --color=auto --icons'
alias lla='exa -T -a --level=2 --color=auto --icons'

alias au='sudo apt update'
alias ai='sudo apt install'
alias ar='sudo apt remove --purge'

alias vv='doas nvim'
alias nv='nvim'
alias sleep='doas pm-suspend-hybrid'
alias poff='doas poweroff'
alias reboot='doas reboot'

alias chmodx='sudo chmod +x'

alias wgeti='wget -N --header="Cache-Control: no-cache" --header="Pragma: no-cache" '
#alias brii='brightnessctl -d intel_backlight s'

alias aliass='doas nvim ~/.bash_aliases'
alias bashrcc='doas nvim ~/.bashrc'

### GIT commands ###
# 1️⃣ Initialize Git (if not already)
# git init --bare ~/.dotfiles  # Only necessary if initializing a new repo

# 2️⃣ Check current status and make sure you're on the correct branch
# git status

# 3️⃣ If you need to create the 'locali' branch or switch:
# git checkout -b locali

# 4️⃣ Add files (e.g., new file) to your git-managed dotfiles
# git add <file_name>

# 5️⃣ Commit your changes
# git commit -m "Add new file or update"

# 6️⃣ Set upstream for the 'locali' branch to track remote
# git push --set-upstream origin locali

# 7️⃣ Push changes to remote (GitHub)
# git push

# 8️⃣ If you need to remove 'main' branch locally and remote (optional):
# git branch -dr origin/main  # Remove local tracking reference
# git remote prune origin     # Clean up remote refs
# git push origin --delete main  # Remove from GitHub (optional)

# 9️⃣ Verify everything is in sync:
# git branch -a               # Check local and remote branches
# git status                  # Verify no further changes to push

alias mygitraw='echo "https://raw.githubusercontent.com/EfeTheCaptain/"'
alias gs='git status'              # Check the status
alias ga='git add'                 # Add files to staging
alias gc='git commit -m'           # Commit changes
alias gm='git branch -m master main' # Rename branch from master to main
alias gra='git remote add origin'  # First push 'gra enter url'
alias gpush='git push -u origin main'  # Push to GitHub
alias gpull='git pull origin main'    # Pull from GitHub

### git revert changes ###
alias gl='git log --oneline --graph --decorate'  # Show commit history
# git reset --soft def2345      # Soft reset to a specific commit

### git discard broken changes ###
# git checkout -- .            
# Discard all changes in the working directory;  
# It will revert any uncommitted changes in your working directory. 
# This means it does not affect the repository itself, but only your local copy of the files.

## YADM a way to add dotfiles to github ##
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
alias ya='yadm add .bash_aliases .bash_profile .bashrc .profile .xinitrc .xprofile .Xresources .config/sxhkd/sxhkdrc .config/system/* .config/bash/* ~/yt-audio ~/Projects/py .config/dunst/dunstrc .config/falkon/themes/win10dark/* .config/qt5ct/qt5ct.conf'
alias yc='yadm commit -m'
alias ypush='yadm push'
alias ypull='yadm pull'

#### APPS TO REMEMBER ###

# acpi (battery-power)
# fim img.jpg (terminal based image viewer)
# xcompmgr (compositor, necessary for alpha patches)
# scrot (screen capture)

#### COMMANDS TO REMEMBER ###
# add-apt-repository
#disk usage of all the files in the given directory, sort reverse human read, top 3
#doas du -ah /home | sort -rh | head -n 3

#ncurses disk usage
#ncdu

#search a package recommendations
#apt-cache show neovim | grep -i Recommends
#netcat share -> nc -l -p 18869 > enc.txt #this recieves the files using that port.
