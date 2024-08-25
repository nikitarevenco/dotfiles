#!/bin/bash

# Define the line to be added
LIMIT_CONF_LINE="- nproc 600"

# Check if the line already exists in /etc/security/limits.conf
if ! grep -qF "$LIMIT_CONF_LINE" /etc/security/limits.conf; then
  echo "Adding line to /etc/security/limits.conf to restrict the number of processes per user..."
  echo "$LIMIT_CONF_LINE" | sudo tee -a /etc/security/limits.conf >/dev/null
  echo "Line added successfully."
else
  echo "The line already exists in /etc/security/limits.conf."
fi

echo "Fork bomb prevention setup is complete."
