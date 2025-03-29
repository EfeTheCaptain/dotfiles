#!/bin/bash

# Define cache file
CACHE_FILE="$HOME/.cache/sys_info_cache"

# Check if cache file exists
if [ ! -f "$CACHE_FILE" ]; then
    # Fetch and cache the system information

    # Read the first word from sys_vendor (vendor)
    cache_reading_2=$(awk '{print $1}' /sys/class/dmi/id/sys_vendor)
    
    # Read the third word from board_name (board name)
    cache_reading_3=$(awk '{print $3}' /sys/class/dmi/id/board_name)
    
    # Read and format the CPU model (e.g., Intel(R) Atom(TM) CPU 550 @1.50GHz -> Intel-Atom-N550)
    cache_reading_1=$(awk -F: '/model name/ {print $2}' /proc/cpuinfo | head -n 1 | awk '{print $1"-"$2"-"$3}' | sed 's/Intel/Intel-/; s/Atom/Atom-/; s/([^)]+)//g')

    # Save the data to the cache file
    echo "$cache_reading_2" > "$CACHE_FILE"
    echo "$cache_reading_3" >> "$CACHE_FILE"
    echo "$cache_reading_1" >> "$CACHE_FILE"
else
    # Read from cache file
    mapfile -t cache_data < "$CACHE_FILE"
    cache_reading_2="${cache_data[0]}"
    cache_reading_3="${cache_data[1]}"
    cache_reading_1="${cache_data[2]}"
fi

# Define colors
bright_sky='\[\e[38;5;117m\]'  # Light Blue (Sunny Sky)
mid_sky='\[\e[38;5;39m\]'     # Medium Blue (Day Sky)
cloud_white='\[\e[38;5;231m\]' # White (Clouds)
sunlit_leaves='\[\e[38;5;118m\]' # Light Green (Sunlit Leaves)
evergreen_dark='\[\e[38;5;22m\]' # Dark Green (Evergreen Needles)
mossy_green='\[\e[38;5;28m\]'      # Moss Green
bark_brown='\[\e[38;5;94m\]'      # Bark Brown
soil_brown='\[\e[38;5;52m\]'      # Soil Brown
sun_yellow='\[\e[38;5;226m\]'    # Bright Yellow (Sun)
forest_shadow='\[\e[38;5;16m\]' # Dark Grey (Shadows)
nc='\[\e[0m\]'

# Define the prompt using cached data with color codes
PS1="\n\[\e[1;${bark_brown}m\]╭ ──[\[$evergreen_dark\]$cache_reading_2-\[$evergreen_dark\]$cache_reading_3\]───╮\n\
\[\e[1;${bark_brown}m\]├──[\[$mossy_green\]$cache_reading_1\]──────╯\n\
\[\e[1;${bark_brown}m\]├[\[$sun_yellow\]\u\[$bright_sky\]@\[$forest_shadow\]\h\[$bright_sky\]]─[\[$mid_sky\]\w]\n\
\[\e[1;${bark_brown}m\]├──▶  \[\e[0m\]"

# Force color interpretation
PS1="$(eval echo -e \"$PS1\")"
