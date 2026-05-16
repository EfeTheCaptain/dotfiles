# ZSH Color Definition Block
COL_GREEN="%{\033[38;5;34m%}"
COL_YELLOW="%{\033[38;5;220m%}"
COL_BLUE="%{\033[38;5;24m%}"
COL_RED="%{\033[38;5;45m%}"
COL_WHITE="%{\033[38;5;224m%}"
COL_RESET="%{\033[0m%}"

# Optional Dynamic Header Function (Triggers only when terminal opens)
# Replaced dpkg with a lightweight Fedora rpm cache count
pkg_count=$(rpm -qa | wc -l)
echo "${COL_GREEN}╭──[ ${COL_RED}Packages: $pkg_count ${COL_GREEN}]───[ ${COL_WHITE} Fedora ${COL_GREEN}]"
echo "${COL_GREEN}╰───[ ${COL_YELLOW}i3-6006U ${COL_GREEN}]${COL_RESET}"

# Build the 2-Line Interactive Prompt
PROMPT="
${COL_GREEN}╭───[ ${COL_YELLOW}%n${COL_BLUE}@%m${COL_GREEN} ]──[ ${COL_RED}%~${COL_GREEN} ]
${COL_GREEN}╰─🠞 ${COL_WHITE}"
