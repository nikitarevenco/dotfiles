export WEZTERM_CONFIG_FILE="$HOME/dotfiles/wezterm.lua"

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep i3 || startx /usr/bin/i3
fi
