#!/bin/bash
SCRIPTS=$(dirname "$(readlink -f "$0")")/.install

# Configure service for increased download speeds
bash "$SCRIPTS/reflector.sh"

# Updates system and syncs package databases
# Install all needed packages for the system
# Configures microcode and regenerates grub config
bash "$SCRIPTS/dependencies.sh"

# Configure ssh
# Disable root login via ssh except from local consoles
bash "$SCRIPTS/ssh.sh"

# Limit amount of processes that can be spawned to a very high amount that won't be
# naturally reached, but will prevent forkbombs
bash "$SCRIPTS/forkbomb-prevent.sh"

# Create symlinks for the dotfiles
bash "$SCRIPTS/create-symlinks.sh"

# Setup ufw (uncomplicated firewall) for protection
bash "$SCRIPTS/firewall.sh"

# Enables network manager
bash "$SCRIPTS/network-manager.sh"

# Configure catppuccin theme for sddm
bash "$SCRIPTS/sddm-theme.sh"

# Configure nextdns
bash "$SCRIPTS/nextdns.sh"

# Security services such as clamav, rkhunter and chkrootkit
# Disable login as root
bash "$SCRIPTS/security.sh"

# Creates the /{user}/home directory structure that I like:
# ~/dotfiles :: Source of configuration files (which are symlinked to ~/.config)
# ~/screenshots :: Screenshots from flameshot are stored here
# ~/repos :: Store all my cloned repos here
# ~/repos/{username}/{repo-name} :: How I like to keep track of my repositories
# ~/downloads :: Downloads from online
# ~/music :: My music
# ~/backup :: Backup files and directories from anywhere else within the system
# ~/secrets :: Encrypted env variable storage using password-store and $(pass show {env-var-name})
bash "$SCRIPTS/directory-structure.sh"

# Apply bat theme
bat cache --build

echo $SCRIPTS
