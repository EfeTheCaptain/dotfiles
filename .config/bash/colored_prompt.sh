# Static Info
package_count="\[\033[38;5;125m\]$(dpkg -l | grep -c '^ii')"
cpu_model="\[\033[38;5;89m\]Intel-Atom-N550"
os_logo="\Uf0238"  # Using Unicode escape for Debian logo

# Print static header (correctly formatted)
echo -e "\n\033[38;5;34m╭──[ ${package_count} \033[38;5;34m]───[\033[0m${os_logo}\033[38;5;34m]"
echo -e "\033[38;5;34m╰───[ ${cpu_model} \033[38;5;34m]\033[0m"

# Define PS1 (with \[ \] for prompt safety)
PS1="\n\
\[\033[38;5;34m\]╭───[\[\033[38;5;220m\]\u\[\033[38;5;34m\]@\h\[\033[38;5;34m\]]──[\[\033[38;5;45m\]\w\[\033[38;5;34m\]]\n\
\[\033[38;5;34m\]╰─🠞 \[\033[0m\] "
