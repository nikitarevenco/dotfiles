# Focus window

alt + {n,e,i,o}
    bspc node -f {west,south,north,east}

alt + {2,8,1,4}
    bspc node -s {west,east,north,east}

alt + {b,p,f,w}
    bspc desktop -f {1,2,3,4}

# Resize window
alt + l
    bspc node -z right -20 +0 && bspc node -z left +20 +0
alt + j
    bspc node -z right +20 +0 && bspc node -z left -20 +0
alt + u
    bspc node -z bottom +0 +20 && bspc node -z top +0 -20
alt + y
    bspc node -z bottom +0 -20 && bspc node -z top +0 +20

# alternate between tiled and monocle layout
alt + m
    bspc desktop -l next

# Close window
alt + t
    bspc node -c

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
