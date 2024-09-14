#!/bin/sh

bspc config border_width 2
bspc config focused_border_color "#cba6f7"
bspc config active_border_color "#181825"
bspc config presel_feedback_color "#fab387"
bspc config normal_border_color "#181825"

bspc monitor -d 1 2 3 4

bspc config window_gap 0
bspc config split_ratio 0.52
bspc config borderless_monocle true
bspc config single_monocle true
bspc config pointer_modifier shift

export WEZTERM_CONFIG_FILE="$HOME/dotfiles/wezterm.lua"

wezterm-gui &
sxhkd &
# Stop cursor from being an "X" when not over a window
xsetroot -cursor_name left_ptr &
