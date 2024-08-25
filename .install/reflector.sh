#!/bin/bash

# Synchronize the package database
sudo pacman -Syy --noconfirm

# Install Reflector
sudo pacman -S --noconfirm reflector

# Update the mirror list with the fastest mirrors in England from the last 6 hours
sudo reflector -c England,Germany,France -a 6 --sort rate --save /etc/pacman.d/mirrorlist

# Update the package database again after updating the mirror list
sudo pacman -Syy

# Create the Reflector configuration file
sudo tee /etc/xdg/reflector/reflector.conf >/dev/null <<EOL
--save /etc/pacman.d/mirrorlist
--country England,Germany,France
--protocol https
--latest 10
EOL

# Enable and start the Reflector service
sudo systemctl enable reflector.service
sudo systemctl start reflector.service
