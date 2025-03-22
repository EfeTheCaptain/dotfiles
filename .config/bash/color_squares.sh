#!/bin/bash

# Source colors.sh to use the new palette
source ~/.config/bash/colors.sh

print_color_squares() {
    local colors=(
        "bright_sky='\e[48;5;117m'"
        "mid_sky='\e[48;5;39m'"
        "cloud_white='\e[48;5;231m'"
        "sunlit_leaves='\e[48;5;118m'"
        "evergreen_dark='\e[48;5;22m'"
        "mossy_green='\e[48;5;28m'"
        "bark_brown='\e[48;5;94m'"
        "soil_brown='\e[48;5;52m'"
        "sun_yellow='\e[48;5;226m'"
        "forest_shadow='\e[48;5;16m'"
    )

    local reset='\e[0m'
    local output=""

    for color in "${colors[@]}"; do
        local name="${color%%=*}"
        local code="${color#*=}"
        output+="${code}  ${reset} $name "
    done

    printf "$output\n"
}
