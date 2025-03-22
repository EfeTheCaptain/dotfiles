#!/bin/bash

# Source colors.sh to use the new palette
source ~/.config/bash/colors.sh

print_color_squares() {
    local colors=(
        "$bright_sky"
        "$mid_sky"
        "$cloud_white"
        "$sunlit_leaves"
        "$evergreen_dark"
        "$mossy_green"
        "$bark_brown"
        "$soil_brown"
        "$sun_yellow"
        "$forest_shadow"
    )

    local reset='\e[0m'
    local output=""

    for color in "${colors[@]}"; do
        output+="${color}${reset}" # Two spaces for square
    done

    printf "%s\n" "$output" # Add newline at the end
}
