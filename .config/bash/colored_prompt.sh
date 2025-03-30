# Color Variables (raw escape codes, no \[ \])
color_193='\033[38;5;193m'
color_005='\033[38;5;005m'
color_087='\033[38;5;087m'
color_231='\033[38;5;231m'
color_184='\033[38;5;184m'
color_114='\033[38;5;114m'
color_045='\033[38;5;045m'
nc='\033[0m'

# Static Info
cpu_model="$(nc)${color_140}Intel-Atom-N550${nc}"
package_count="${color_087}$(dpkg -l | grep -c '^ii')${nc}"
os_logo="${color_231}\Uf0238${nc}"  # Using Unicode escape for Debian logo

# Print static header (correctly formatted)
echo -e "\n${color_193}╭──[ ${package_count} ${color_193}]───[ ${os_logo} ${color_193}]"
echo -e "${color_193}╰───[ ${cpu_model} ${color_193}]\n"

# Define PS1 (with \[ \] for prompt safety)
PS1="\n\[\033[38;5;193m\]╭───[\[\033[38;5;220m\]\u\[\033[38;5;157m\]@\h\[\033[38;5;193m\]]──[\[\033[38;5;045m\]\w\[\033[38;5;193m\]]\n\[\033[38;5;087m\]╰─🠞 \[\033[0m\] "
