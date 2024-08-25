#!/bin/bash

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Check if the temporary directory was created
if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
  echo "Could not create temp directory"
  exit 1
fi

# Function to remove the temporary directory on exit
function cleanup {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Download the file to the temporary directory
curl -L -o "$TEMP_DIR/testing.zip" https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip

# Unzip the file to the temporary directory
unzip "$TEMP_DIR/testing.zip" -d "$TEMP_DIR"

# Remove any existing theme directory
sudo rm -rf /usr/share/sddm/themes/catppuccin-mocha

# Move the unzipped theme to /usr/share/sddm/themes
sudo mv "$TEMP_DIR/catppuccin-mocha" /usr/share/sddm/themes/

# Update or create the /etc/sddm.conf file
if [[ ! -f /etc/sddm.conf ]]; then
  sudo bash -c 'cat > /etc/sddm.conf <<EOF
[Theme]
Current=catppuccin-mocha
EOF'
else
  sudo sed -i 's|^\([[:space:]]*Current[[:space:]]*=\).*|\1catppuccin-mocha|' /etc/sddm.conf
fi

sudo systemctl enable sddm
