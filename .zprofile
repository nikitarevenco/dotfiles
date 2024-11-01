export WEZTERM_CONFIG_FILE="$HOME/dotfiles/wezterm"

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep i3 || startx $(which i3)
fi
