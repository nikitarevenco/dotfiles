# Nikita Revenco's Dotfiles

<details>
<summary>
NixOS Installation
</summary>

Enter as root

<details>
<summary>
Connect to Internet
</summary>

```
passwd root
su
```

Find out the SSID for wifi network with:

```
iwlist scan | grep ESSID
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
</details>

Partition

```bash
sgdisk -Z -n1:0:+512M -t1:ef02 -c1:boot -N2 -t2:8309 -c2:luks_root /dev/sdX
```

Luks setup and open

```bash
cryptsetup luksFormat /dev/disk/by-partlabel/luks_root
cryptsetup luksOpen /dev/disk/by-partlabel/luks_root cryptroot
```

Two logical volumes, 8GB swap and rest is root

```bash
pvcreate /dev/mapper/cryptroot
vgcreate vg /dev/mapper/cryptroot
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg
```

Format the partitions

```bash
mkfs.fat /dev/disk/by-partlabel/boot
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
```

Install nixOS

```
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/disk/by-partlabel/boot /mnt/boot
swapon /dev/vg/swap
```

Final steps

```bash
nix-shell -p git
git clone https://github.com/nikitarevenco/dotfiles.git /mnt/etc/nixos
nixos-generate-config --root /mnt --show-hardware-config > /mnt/etc/nixos/hardware-configuration.nix
nixos-install
```

```bash
cp /etc/wpa_supplicant.conf /mnt/etc/wpa_supplicant.conf

passwd e

reboot
```
