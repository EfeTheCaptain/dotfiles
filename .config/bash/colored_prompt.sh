# Color Variables (raw escape codes, no \[ \])
color_120='\033[38;5;120m'
color_005='\033[38;5;005m'
color_087='\033[38;5;087m'
color_231='\033[38;5;231m'
color_184='\033[38;5;184m'
color_114='\033[38;5;114m'
color_045='\033[38;5;045m'
nc='\033[0m'

# Static Info
cpu_model="${color_140}Intel-Atom-N550${nc}"
package_count="${color_087}$(dpkg -l | grep -c '^ii')${nc}"
os_logo="${color_231}\Uf0238${nc}"  # Using Unicode escape for Debian logo

# Print static header (correctly formatted)
echo -e "\n${color_120}╭──[ ${package_count} ${color_120}]───[ ${os_logo} ${color_120}]"
echo -e "${color_120}╰───[ ${cpu_model} ${color_120}]\n"

# Define PS1 (with \[ \] for prompt safety)
PS1="\n\[\033[38;5;120m\]╭───[\[\033[38;5;142m\]\u\[\033[38;5;158m\]@\h\[\033[38;5;120m\]]──[\[\033[38;5;045m\]\w\[\033[38;5;120m\]]\n\[\033[38;5;120m\]╰─🠞 \[\033[0m\] "
