#!/bin/bash

# Define the number of workspaces
num_workspaces=10

# Function to get the window titles for each workspace
get_window_titles() {
    for i in $(seq 0 $((num_workspaces-1))); do
        # Get the window details for each workspace
        window_details=$(wmctrl -l | awk -v workspace=$i '$2 == workspace {print $0}')
        # Initialize window titles
        window_titles=""
        while IFS= read -r line; do
            window_title=$(echo "$line" | cut -d' ' -f5-)
            if [ -n "$window_title" ]; then
                window_titles+="$window_title, "
            fi
        done <<< "$window_details"
        # Remove trailing comma and space
        window_titles=${window_titles%, }
        # Handle empty workspaces
        if [ -z "$window_titles" ]; then
            window_titles=""
        fi
        # Print workspace number and window titles
        echo "$((i+1)): $window_titles"
    done
}

# Get the list of window titles for each workspace
window_list=$(get_window_titles)

# Display the window list using rofi and prompt user to select a workspace
selected=$(echo "$window_list" | rofi -dmenu -i -l 10 -p "Select workspace:" \
    -kb-accept-entry '!1,!2,!3,!4,!5,!6,!7,!8,!9,!0,Return' \
    -theme ~/.config/rofi/themes/workspaces.rasi | awk '{print $2}' | tr -d ':')

# Ensure selected is a valid number and convert it to zero-based index
if [[ "$selected" =~ ^[0-9]+$ ]]; then
    workspace_number=$((selected))
    bspc desktop -f "^${workspace_number}"
fi
