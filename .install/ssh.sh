#!/bin/bash

# Install OpenSSH server if not already installed
if ! command -v sshd &>/dev/null; then
  echo "Installing OpenSSH server..."
  sudo pacman -S openssh --noconfirm
else
  echo "OpenSSH server is already installed."
fi

# Check if SSH service is enabled and running
if systemctl is-enabled --quiet sshd && systemctl is-active --quiet sshd; then
  echo "SSH service is already enabled and running."
else
  echo "Enabling and starting SSH service..."
  sudo systemctl enable sshd
  sudo systemctl start sshd
fi

# Generate SSH keys if they don't already exist
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Generating SSH keys..."
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
  echo "SSH keys generated."
else
  echo "SSH keys already exist."
fi

# Disable root login via SSH
SSHD_CONFIG="/etc/ssh/sshd_config"
if grep -q "^PermitRootLogin" $SSHD_CONFIG; then
  sudo sed -i "s/^PermitRootLogin.*/PermitRootLogin no/" $SSHD_CONFIG
else
  echo "PermitRootLogin no" | sudo tee -a $SSHD_CONFIG
fi

echo "Restarting SSH service to apply changes..."
sudo systemctl restart sshd

# Edit /etc/security/access.conf to prevent remote root logins except from local consoles
ACCESS_CONF="/etc/security/access.conf"
if ! grep -q "^\\-:root:ALL except LOCAL" $ACCESS_CONF; then
  echo "Editing /etc/security/access.conf to prevent remote root logins except from local consoles..."
  echo "-:root:ALL except LOCAL" | sudo tee -a $ACCESS_CONF
else
  echo "The line to prevent remote root logins except from local consoles is already present in $ACCESS_CONF."
fi

# Provide instructions for adding the public key to authorized_keys
echo "To add your public key to a remote server's authorized_keys file, run the following command:"
echo "ssh-copy-id username@remote_host"
echo "Replace 'username' with your remote username and 'remote_host' with the remote host's address."

echo "SSH setup is complete."
