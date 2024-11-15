# Nikita's NixOS Dotfiles

My minimalistic dotfiles, with just the tools that I really use. Some of my thoughts on NixOS:

- NixOS is my favorite way to manage configurations, because the entire system can be configured from just a single file: [configuration.nix](./configuration.nix)
- What's especially awesome, is that I can configure `about:config` values and extensions for Firefox in [firefox.nix](./firefox). This lets me have the same browser across every single computer!
- I feel like NixOS is a cheat code, it's impossible for my computer to ever break. If something has gone wrong, I can just boot into a configuration from yesterday and continue being productive.
- Since it's available on Mac, I'm not locked into using NixOS. I can use other linux distros as well as MacOS.
- Setting up a new computer with all of my configs takes literally just 10 minutes, most of which is waiting for stuff to install. Oh my god!

## Installation Instructions

If you aren't, connect to wifi by following these steps from the installation media:

Find out SSID and INTERFACE with:

```bash
iwlist scan | grep ESSID && ip link
```

Generate WiFi configuration and connect to wifi:

```bash
wpa_passphrase SSID PASSWORD > /etc/wpa_supplicant.conf
wpa_supplicant -B -i INTERFACE -c /etc/wpa_supplicant.conf
```

## Partitioning

Partition drives:

```bash
sgdisk -Z -n1:0:+512M -t1:ef02 -c1:boot \
       -N2 -t2:8309 -c2:root /dev/sdX
```

Luks setup:

```bash
cryptsetup luksFormat /dev/disk/by-partlabel/root
cryptsetup luksOpen /dev/disk/by-partlabel/root cryptroot
```

Set up logical volumes:

```bash
pvcreate /dev/mapper/cryptroot
vgcreate vg /dev/mapper/cryptroot
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg
```

Format partitions:

```bash
mkfs.fat /dev/disk/by-partlabel/boot
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
```

## Main Installation

Install nixOS

```bash
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/disk/by-partlabel/boot /mnt/boot
swapon /dev/vg/swap
```

Copy wpa_supplicant configuration:

```bash
cp /etc/wpa_supplicant.conf /mnt/etc/wpa_supplicant.conf
```

Final steps

```bash
nix-shell -p git
git clone https://github.com/nikitarevenco/dotfiles.git \
          /mnt/etc/nixos
nixos-generate-config --root /mnt --show-hardware-config \
            > /mnt/etc/nix/hardware.nix
nixos-install
reboot
```
