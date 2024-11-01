# Nikita Revenco's Dotfiles

<details>
<summary>
NixOS Installation
</summary>

Find out the SSID for wifi network with:

```
sudo iwlist scan | grep ESSID
```

Generate configuration for wifi:

```bash
wpa_passphrase SSID PASSWORD > /etc/wpa_supplicant.conf
```

Find out INTERFACE with

```bash
ip link
```

Connect to wifi

```bash
wpa_supplicant -B -i INTERFACE -c /etc/wpa_supplicant.conf
```

Partition

```bash
sgdisk -Z -n1:0:+512M -t1:ef02 -c1:boot -N2 -t3:8309 -c3:luks_root /dev/sdX
```

Luks setup and open

```bash
cryptsetup luksFormat /dev/sdX2
cryptsetup luksOpen /dev/sdX2 enc-pv
```

Two logical volumes, 8GB swap and rest is root

```bash
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg
```

Format the partitions

```bash
mkfs.fat /dev/sda1
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
```

Install nixOS

```
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/sdX1 /mnt/boot
swapon /dev/vg/swap
```

Copy wifi settings

```bash
cp /etc/wpa_supplicant.conf /mnt/etc/wpa_supplicant.conf
```

Final steps

```bash
nixos-generate-config --root /mnt
nixos-install
reboot
```

</details>

Connect to wifi in nix installation

```bash
# find out the wireless interface you are using
ip link


```

Clone repo

```bash
git clone https://github.com/nikitarevenco/dotfiles.git ~/dotfiles
```

Create directories

```bash
mkdir -p ~/.ssh ~/.config/i3 ~/.config/nvim ~/a ~/r ~/s ~/t
```

Create symlinks

```bash
ln -sf ~/dotfiles/i3 ~/.config/i3/config && ln -sf ~/dotfiles/zsh ~/.zshrc && ln -sf ~/dotfiles/.zprofile ~/.zprofile && ln -sf ~/dotfiles/neovim ~/.config/nvim/init.lua && sudo ln -sf ~/dotfiles/nixos /etc/nixos/configuration.nix
```

Generate SSH Key for GitHub

```bash
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" && cat "$HOME/.ssh/id_ed25519.pub"
```
