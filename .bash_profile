# .bash_profile
export PATH=$PATH:/usr/sbin:/usr/bin
export QT_QPA_PLATFORMTHEME=gtk2
export HISTSIZE=100
export HISTSIZE=250


~/.profile


if [ -f "$HOME/.bashrc"  ]; then
	. "$HOME/.bashrc"
fi


brightnessctl -d intel_backlight s 10%

sudo /usr/bin/loadkeys trq

sudo /usr/sbin/ip link set wlan0 up
sudo /usr/sbin/wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
sudo /usr/sbin/dhclient wlan0

eval "$(ssh-agent -s)"
. "$HOME/.cargo/env"


# Created by `pipx` on 2025-03-17 21:39:20
export PATH="$PATH:/home/efe/.local/bin"
