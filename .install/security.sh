#!/bin/bash

# Enable and update ClamAV services
echo "Enabling and starting ClamAV services..."
sudo systemctl enable clamav-freshclam.service
sudo systemctl start clamav-freshclam.service
sudo freshclam

# Create systemd service and timer for ClamAV scan
echo "Creating systemd service and timer for ClamAV scan..."
cat <<EOF | sudo tee /etc/systemd/system/clamav-scan.service
[Unit]
Description=Run ClamAV Scan

[Service]
ExecStart=/usr/bin/clamscan -r /
EOF

cat <<EOF | sudo tee /etc/systemd/system/clamav-scan.timer
[Unit]
Description=Daily ClamAV Scan

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Create systemd service and timer for chkrootkit scan
echo "Creating systemd service and timer for chkrootkit scan..."
cat <<EOF | sudo tee /etc/systemd/system/chkrootkit-scan.service
[Unit]
Description=Run chkrootkit Scan

[Service]
ExecStart=/usr/bin/chkrootkit
EOF

cat <<EOF | sudo tee /etc/systemd/system/chkrootkit-scan.timer
[Unit]
Description=Daily chkrootkit Scan

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Create systemd service and timer for rkhunter scan
echo "Creating systemd service and timer for rkhunter scan..."
cat <<EOF | sudo tee /etc/systemd/system/rkhunter-scan.service
[Unit]
Description=Run rkhunter Scan

[Service]
ExecStart=/usr/bin/rkhunter --check
EOF

cat <<EOF | sudo tee /etc/systemd/system/rkhunter-scan.timer
[Unit]
Description=Daily rkhunter Scan

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start the timers
echo "Enabling and starting systemd timers..."
sudo systemctl enable clamav-scan.timer
sudo systemctl start clamav-scan.timer
sudo systemctl enable chkrootkit-scan.timer
sudo systemctl start chkrootkit-scan.timer
sudo systemctl enable rkhunter-scan.timer
sudo systemctl start rkhunter-scan.timer

echo "Disabling login as root..."
sudo passwd -l root

echo "Security tools setup is complete. Scans are scheduled to run daily and will catch up if the system is off at the scheduled time."
