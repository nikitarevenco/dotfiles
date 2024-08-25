echo "Setting up a firewall..."

sudo systemctl enable ufw.service --now
sudo ufw enable
sudo ufw limit SSH
sudo ufw logging off
