#!/bin/bash

echo "Updating repositories and upgrading packages..."
sudo pacman -Syu --noconfirm

# For microcode
cpu_vendor=$(lscpu | grep "Vendor ID" | awk '{print $3}')

case $cpu_vendor in
"AuthenticAMD")
  ucode_package="amd-ucode"
  ;;
"GenuineIntel")
  ucode_package="intel-ucode"
  ;;
*)
  echo "WARN: Unknown CPU vendor: $cpu_vendor"
  echo "WARN: Not installing or updating your microcode."
  exit 1
  ;;
esac

core_packages=()
security=()
dev_tools=()
utilities=()
media=()
web_browsers=()
programming_languages=()
window_manager=()
aur_packages=()
additional_tools=()

# Core packages
core_packages+=("base-devel")     # Essential development tools
core_packages+=($ucode_package)   # Microcode
core_packages+=("networkmanager") # Network Manager
core_packages+=("npm")            # Node package manager

# Development tools
dev_tools+=("git")          # Version control system
dev_tools+=("vim")          # Vi IMproved, a programmer's text editor
dev_tools+=("neovim")       # Vim-based text editor
dev_tools+=("python-pip")   # Python package installer
dev_tools+=("python-black") # Python code formatter
dev_tools+=("python-isort") # Python import sorter
dev_tools+=("composer")     # Dependency manager for PHP
dev_tools+=("cargo")        # Rust package manager
dev_tools+=("luarocks")     # Lua package manager
dev_tools+=("jdk-openjdk")  # OpenJDK Java development kit
dev_tools+=("nodejs")       # JavaScript runtime
dev_tools+=("vscode")       # JavaScript runtime
dev_tools+=("ruby")         # Ruby programming language
dev_tools+=("julia")        # Julia programming language
dev_tools+=("lazygit")      # Simple terminal UI for git commands
dev_tools+=("yank")         # Yank terminal output to clipboard

# Utilities
utilities+=("curl")            # Command-line tool for transferring data
utilities+=("pacman-contrib")  # For paccahe.service to clean pacman cache
utilities+=("unzip")           # Utility to unzip files
utilities+=("xclip")           # Command line clipboard utility
utilities+=("xorg-xmodmap")    # Utility for modifying keymaps and pointer button mappings
utilities+=("xorg-xev")        # Print contents of X events
utilities+=("xorg-xrandr")     # Configuring screen resolutions (workspaces script)
utilities+=("scrot")           # Command-line screenshot utility (workspaces script)
utilities+=("xorg-xsetroot")   # Utility to change the characteristics of the root window
utilities+=("starship")        # Shell prompt
utilities+=("ripgrep")         # Line-oriented search tool
utilities+=("fzf")             # Command-line fuzzy finder
utilities+=("zoxide")          # Faster way to navigate your filesystem
utilities+=("pass")            # Password manager
utilities+=("bat")             # cat clone with syntax highlighting
utilities+=("zsh")             # Z shell
utilities+=("man-db")          # Utilities to read man pages
utilities+=("zsh-completions") # Additional completion definitions for Zsh
utilities+=("openssh")         # OpenSSH client and server
utilities+=("fd")              # Simple, fast and user-friendly alternative to find
utilities+=("eza")             # Modern replacement for ls
utilities+=("trash-cli")       # Command line interface to the freedesktop.org trashcan
utilities+=("kitty")           # Terminal emulator
utilities+=("yazi")            # Console file manager
utilities+=("unarchiver")      # Yazi archive preview
utilities+=("jq")              # Yazi JSON preview
utilities+=("poppler")         # Yazi PDF preview
utilities+=("ufw")             # Firewall
utilities+=("bpytop")          # Terminal system monitor

# Media and graphics
media+=("alsa-utils")        # For dunst notifications
media+=("imagemagick")       # Image manipulation tools
media+=("ffmpegthumbnailer") # Lightweight video thumbnailer
media+=("feh")               # Fast and light image viewer
media+=("flameshot")         # Powerful screenshot utility
media+=("gimp")              # GNU Image Manipulation Program
media+=("chafa")             # Image to text converter
media+=("obs-studio")        # Streaming and recording software
media+=("noto-fonts-emoji")  # Emoji fonts
media+=("noto-fonts")        # Font family of various fonts
media+=("libreoffice")       # Office files editing
media+=("mpv")               # Video player
media+=("kdenlive")          # Video editor

# Web browsers and email
web_browsers+=("firefox") # Web browser

# Window manager and related tools
window_manager+=("bspwm")        # Tiling window manager
window_manager+=("sxhkd")        # Simple X hotkey daemon
window_manager+=("polybar")      # Status bar
window_manager+=("picom")        # X compositor
window_manager+=("dmenu")        # Dynamic menu
window_manager+=("dunst")        # Notification daemon
window_manager+=("nitrogen")     # Background setter for X windows
window_manager+=("hsetroot")     # Utility to compose wallpapers
window_manager+=("i3lock")       # Simple screen locker
window_manager+=("rofi")         # Window switcher, application launcher, and dmenu replacement
window_manager+=("sddm")         # Simple Desktop Display Manager
window_manager+=("lxappearance") # GTK+ theme switcher

security+=("rkhunter") # Checker
security+=("clamav")   # Anti-virus
security+=("clamtk")   # Anti-virus

# AUR packages
aur_packages+=("catppuccin-cursors-latte")       # Catppuccin cursors
aur_packages+=("catppuccin-gtk-theme-mocha")     # Catppuccin GTK theme
aur_packages+=("papirus-folders-catppuccin-git") # Papirus folders Catppuccin
aur_packages+=("chkrootkit")                     # Papirus folders Catppuccin
aur_packages+=("nvm")                            # Papirus folders Catppuccin
aur_packages+=("tinyfetch")                      # My minimalistic fetch

# Install core packages
echo "Installing core packages..."
sudo pacman -S --noconfirm "${core_packages[@]}"

# Install development tools
echo "Installing development tools..."
sudo pacman -S --noconfirm "${dev_tools[@]}"

# Install utilities
echo "Installing utilities..."
sudo pacman -S --noconfirm "${utilities[@]}"

# Install media and graphics tools
echo "Installing media and graphics tools..."
sudo pacman -S --noconfirm "${media[@]}"

# Install web browsers and email clients
echo "Installing web browsers and email clients..."
sudo pacman -S --noconfirm "${web_browsers[@]}"

# Install security tools
echo "Installing security tools..."
sudo pacman -S --noconfirm "${security[@]}"

# Install window manager and related tools
echo "Installing window manager and related tools..."
sudo pacman -S --noconfirm "${window_manager[@]}"

# Install yay (AUR helper)
echo "Installing yay..."
tmp_dir=$(mktemp -d -t yay-XXXXXXXXXX)
git clone https://aur.archlinux.org/yay.git "$tmp_dir"
pushd "$tmp_dir"
makepkg -si --noconfirm
popd
rm -rf "$tmp_dir"

# Install AUR packages
echo "Installing AUR packages..."
yay -S --noconfirm "${aur_packages[@]}"

# Install additional tools using other package managers
echo "Installing additional tools..."
sudo cargo install stylua
sudo npm install -g eslint_d @fsouza/prettierd ts-node

if systemctl is-active --quiet paccache.timer; then
  echo "paccache.timer is already active."
else
  echo "paccache.timer is not active. Activating it now..."
  sudo systemctl enable paccache.timer --now
fi

echo "All installations completed successfully."

grub-mkconfig -o /boot/grub/grub.cfg
grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg

echo "Regenerated GRUB Config for microcode"
