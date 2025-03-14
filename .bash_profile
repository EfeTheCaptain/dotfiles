# .bash_profile
export PATH=$PATH:/usr/sbin:/usr/bin
~/.profile
brightnessctl -d intel_backlight s 25%

if [ -f "$HOME/.bashrc"  ]; then
	. "$HOME/.bashrc"
fi

sudo /usr/bin/loadkeys trq

sudo /usr/sbin/ip link set wlan0 up
sudo /usr/sbin/wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
sudo /usr/sbin/dhclient wlan0

eval "$(ssh-agent -s)"
. "$HOME/.cargo/env"
