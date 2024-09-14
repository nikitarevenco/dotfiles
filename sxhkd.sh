# Focus window
alt + b
    bspc node -f west
alt + o
    bspc node -f east
alt + e
    bspc node -f north
alt + i
    bspc node -f south

# Move window
alt + 2
    bspc node -s west
alt + 8
    bspc node -s east
alt + 1
    bspc node -s north
alt + 4
    bspc node -s south

# Resize window
alt + l
    bspc node -z right -20 0
alt + j
    bspc node -z right +20 0
alt + u
    bspc node -z bottom +0 +20
alt + y
    bspc node -z bottom +0 -20

# Toggle floating (centered)
alt + q
    bspc node -t floating && bspc node -v center

# Toggle tiling mode
alt + g
    bspc node -t tiled

# Toggle fullscreen
alt + f
    bspc node -t fullscreen

# Toggle minimized (hidden state in bspwm)
alt + m
    bspc node -g hidden -f

# Close window
alt + t
    bspc node -c

# Switch workspace (desktop in bspwm)
alt + b
    bspc desktop -f 1
alt + p
    bspc desktop -f 2
alt + f
    bspc desktop -f 3
alt + w
    bspc desktop -f 4

# Move window to workspace
alt + 7
    bspc node -d 1
alt + 3
    bspc node -d 2
alt + 0
    bspc node -d 3
alt + 5
    bspc node -d 4

# Open applications
alt + s
    wezterm-gui
alt + r
    firefox
alt + k
    nohup flameshot 0</dev/null 1>/dev/null 2>/dev/null & ; flameshot gui

# Focus recent workspace
alt + v
    bspc desktop -f last

# Quit BSPWM
alt + z
    bspc quit

# Reload configuration
alt + Escape
    bspc wm -r

super + d
    dmenu_run
