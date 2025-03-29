#!/bin/bash

# Define cache file
CACHE_FILE="$HOME/.cache/sys_info_cache"

# Check if cache file exists
if [ ! -f "$CACHE_FILE" ]; then
    # Fetch and cache the system information
    cache_reading_2=$(awk '{print $1}' /sys/class/dmi/id/sys_vendor)
    cache_reading_3=$(awk '{print $3}' /sys/class/dmi/id/board_name)
    cache_reading_1=$(awk '/model name/ {print $3, $4, $5}' /proc/cpuinfo | awk '{print $1"-"$2"-"$3}' | sed 's/^/Intel-/;s/@.*//')

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

# Define the prompt using cached data
PS1="\n\[\e[1;32m\]╭────[$cache_reading_2]───╮\n\[\e[1;32m\]├──[$cache_reading_1]──────╯\n\[\e[1;32m\]├[user@\h]─[\w]\n\[\e[1;32m\]╰──▶  \[\e[0m\] "

# Force color interpretation
PS1="$(eval echo -e \"$PS1\")"
