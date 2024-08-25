#!/bin/bash

# Get the ID of the currently focused window
window_id=$(bspc query -N -n focused)

# Check if window_id is empty
if [ -z "$window_id" ]; then
    exit 1
fi

# Get the current opacity of the window
current_opacity=$(xprop -id "$window_id" _NET_WM_WINDOW_OPACITY | awk '{print $3}')

# Default opacity if property is not set
if [ -z "$current_opacity" ] || [[ "$current_opacity" == "found." ]]; then
    current_opacity="0xffffffff"
fi

# Convert hexadecimal to decimal
current_opacity_dec=$(printf "%d\n" "$current_opacity")
current_opacity_percent=$((current_opacity_dec * 100 / 4294967295))

# Function to set the opacity
set_opacity() {
    local new_opacity=$1
    local new_opacity_hex=$(printf "0x%x\n" $((new_opacity * 4294967295 / 100)))
    xprop -id "$window_id" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $new_opacity_hex
}

# Handle arguments
case $1 in
    toggle)
        if [ "$current_opacity_percent" -lt 100 ]; then
            set_opacity 100
        else
            set_opacity 80
        fi
        ;;
    up)
        new_opacity=$((current_opacity_percent + 10))
        if [ "$new_opacity" -gt 100 ]; then
            new_opacity=100
        fi
        set_opacity $new_opacity
        ;;
    down)
        new_opacity=$((current_opacity_percent - 10))
        if [ "$new_opacity" -lt 0 ]; then
            new_opacity=0
        fi
        set_opacity $new_opacity
        ;;
    *)
        echo "Invalid argument. Use 'toggle', 'up', or 'down'."
        exit 1
        ;;
esac
