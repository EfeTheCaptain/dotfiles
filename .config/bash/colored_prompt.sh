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
    
    # Concatenate vendor and board name correctly (e.g., SAMSUNG-NF210)
    cache_reading_2_board="${cache_reading_2}-${cache_reading_3}"

    # Read and format the CPU model (e.g., Intel(R) Atom(TM) CPU 550 @1.50GHz -> Intel-Atom-N550)
    cache_reading_1=$(awk -F: '/model name/ {print $2}' /proc/cpuinfo | head -n 1 | awk '{print $1"-"$2"-"$3}' | sed 's/Intel/Intel-/; s/Atom/Atom-/; s/([^)]+)//g')

    # Save the data to the cache file
    echo "$cache_reading_2_board" > "$CACHE_FILE"
    echo "$cache_reading_1" >> "$CACHE_FILE"
else
    # Read from cache file
    mapfile -t cache_data < "$CACHE_FILE"
    cache_reading_2_board="${cache_data[0]}"
    cache_reading_1="${cache_data[1]}"
fi

# Define the prompt without colors
PS1="\n╭ ──[$cache_reading_2_board]───╮\n\
├──[$cache_reading_1]──────╯\n\
├[\u@\h]─[\w]\n\
╰──▶  "
