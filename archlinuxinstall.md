# Steps to Install Arch Linux

## Creating a Bootable USB Drive

### Download

1. Download the `.iso`, `.iso.sig`, `b2sums.txt`, and `sha256sums.txt` files from the Arch Linux install page (Arch Linux > Download > Worldwide > geo.mirror.pkgbuild.com).
2. Download [Balena Etcher](https://etcher.balena.io/).

### Security

#### Verify the Hash Sum of the Image:

```bash
# In the same folder as the .iso
# Expected output: OK
b2sum -c b2sums.txt --ignore-missing

# Expected output: OK
sha256sum -c sha256sums.txt --ignore-missing

# Download and import the public key to verify the signature
gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org
gpg --verify archlinux.iso.sig
```

### Flashing

Open Balena Etcher, select your `.iso` and your drive, and flash.

## Installing Arch

Boot from the USB stick into the Arch ISO installer.

### Keyboard Layout (Optional)

```bash
localectl list-keymaps # Find all keyboard layouts.
loadkeys us # This is the default.
```

### Setting Up an Internet Connection

#### Connecting via Ethernet Cable

Plug an ethernet cable in; the internet should work out of the box.

#### Connecting via Wi-Fi

```bash
iwctl
device list # Choose the station/device name to connect to, e.g., `foo`, and the Wi-Fi name `bar`
station foo connect bar

# Verify internet connection, ensure you receive responses before proceeding
ping -c 4 archlinux.org
exit
```

#### Override Your Hard Drive with Random Data (Optional):

This will completely erase all data on the hard drives.

```bash
lsblk # Find the drives you want to override, e.g., `foo` and `bar`

# Process will take about 8 hours
dd if=/dev/urandom of=/dev/foo bs=4096 status=progress
dd if=/dev/urandom of=/dev/bar bs=4096 status=progress
```

### Setting Up the Partitions

Get the names of the blocks

```
$ lsblk
```

For both partition setups, you'll want to setup a table on your primary drive.

```
$ gdisk /dev/block_name
```

Inside of gdisk, you can print the table using the `p` command.

To create a new partition use the `n` command. The below table shows
the disk setup I have for my primary drive

| partition | first sector | last sector | code |
| --------- | ------------ | ----------- | ---- |
| 1 (efi)   | default      | +512M       | ef00 |
| 2 (boot)  | default      | +4G         | ef02 |
| 3 (root)  | default      | default     | 8309 |

If you have a second drive for your home disk, then your table would be as
follows.

| partition | first sector | last sector | code |
| --------- | ------------ | ----------- | ---- |
| 1 (home)  | default      | default     | 8302 |

When done setting up the partitions, `w` to write.

#### Encrypt the Partitions

Make sure the encryption modules are loaded.

```bash
modprobe dm-crypt
modprobe dm-mod
```

Setting up encryption on our luks lvm partiton

```bash
cryptsetup luksFormat -v -s 512 -h sha512 /dev/a...3 # root
```

If you have a home partition:

```bash
cryptsetup luksFormat -v -s 512 -h sha512 /dev/b...1 # home
```

Mount the drives:

```bash
cryptsetup open /dev/a...3 luks_lvm # root
```

If you have a home parition:

```bash
cryptsetup open /dev/b...1 arch-home # home
```

### Volume setup

Create the volume and volume group

```bash
pvcreate /dev/mapper/luks_lvm

vgcreate arch /dev/mapper/luks_lvm
```

Create a volume for your swap space. A good size for this is your RAM size + 2GB.

```bash
lvcreate -n swap -L 66G arch
```

Next you have a few options depending on your setup

### Single Disk

If you have a single disk, you can either have a single volume for your root
and home, or two separate volumes.

#### Single volume

Single volume is the most straightforward. To do this, just use the entire
disk space for your root volume

```bash
lvcreate -n root -l +100%FREE arch
```

#### Two volumes

For two volumes, you'll need to estimate the max size you want for either your
root or home volumes. With a root volume of 200G, this looks like:

```bash
lvcreate -n root -L 200G arch
```

Then use remaining disk space for home

```bash
lvcreate -n home -l +100%FREE arch
```

### Dual Disk

If you have two disks, then create a single volume on your LVM disk.

```bash
lvcreate -n root -l +100%FREE arch
```

## Filesystems

FAT32 on EFI partiton

```bash
mkfs.fat -F32 /dev/a...1
```

EXT4 on Boot partiton

```bash
mkfs.ext4 /dev/a...2
```

BTRFS on root

```bash
mkfs.btrfs -L root /dev/mapper/arch-root
```

BTRFS on home if exists

```bash
mkfs.btrfs -L home /dev/mapper/arch-home
```

Setup swap device

```bash
mkswap /dev/mapper/arch-swap
```

### Mounting

Mount swap

```bash
swapon /dev/mapper/arch-swap
swapon -a
```

Mount root

```bash
mount /dev/mapper/arch-root /mnt
```

Create boot

```bash
mkdir -p /mnt/boot
```

If you have a home:

```bash
mkdir -p /mnt/home
```

Mount the boot partiton

```bash
mount /dev/a...2 /mnt/boot
```

Mount the home partition if you have one, otherwise skip this

```bash
mount /dev/mapper/arch-home /mnt/home
```

Create the efi directory

```bash
mkdir /mnt/boot/efi
```

Mount the EFI directory

```bash
mount /dev/a...1 /mnt/boot/efi
```

### Install arch

```bash
pacstrap -K /mnt base base-devel linux linux-firmware neovim btrfs-progs lvm2 grub efibootmgr zsh
```

Load the file table

```bash
genfstab -U -p /mnt > /mnt/etc/fstab
```

chroot into your installation

```bash
arch-chroot /mnt /bin/bash
```

## Configuring

### Decrypting volumes

Add `encrypt` and `lvm2` into the hooks array between `block` and `filesystems` in `/etc/mkinitcpio.conf`:

### Bootloader

Setup grub on efi partition

```bash
grub-install --efi-directory=/boot/efi
```

```bash
nvim /etc/default/grub
```

Add in the following kernel parameters
You can fill in the `<uuid>` by typing `:r !blkid /dev/a...3`

```bash
root=/dev/mapper/arch-root cryptdevice=UUID=<uuid>:luks_lvm
```

### Keyfile

```bash
mkdir /secure
```

Root keyfile

```bash
dd if=/dev/random of=/secure/root_keyfile.bin bs=512 count=8
```

Home keyfile if home partition exists

```bash
dd if=/dev/random of=/secure/home_keyfile.bin bs=512 count=8
```

Change permissions on these

```bash
chmod 000 /secure/*
```

Add to partitions

```bash
cryptsetup luksAddKey /dev/a...3 /secure/root_keyfile.bin

# skip below if using single disk
cryptsetup luksAddKey /dev/b...1 /secure/home_keyfile.bin
```

```bash
nvim /etc/mkinitcpio.conf
```

Add this:

```bash
FILES=(/secure/root_keyfile.bin)
```

### Home Partition Crypttab (Skip if single disk)

Open up the crypt table.

```bash
nvim /etc/crypttab
```

Add in the following line at the bottom of the table
You can get `<uuid>` by `:r !blkid /dev/b...1`

```bash
arch-home      UUID=<uuid>    /secure/home_keyfile.bin
```

Reload linux

```bash
mkinitcpio -p linux
```

### Grub

Create grub config

```bash
grub-mkconfig -o /boot/grub/grub.cfg
grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
```

### System Configuration

#### Timezone

```bash
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
```

#### NTP

```bash
nvim /etc/systemd/timesyncd.conf
```

Add in the NTP servers

```bash
[Time]
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org
```

Enable timesyncd

```bash
systemctl enable systemd-timesyncd.service
```

#### Locale

Uncomment the UTF8 lang you want:

```bash
nvim /etc/locale.gen
```

```bash
locale-gen
```

```bash
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
```

#### hostname

```bash
echo "arch" > /etc/hostname
```

#### Users

First secure the root user by setting a password

```bash
passwd
```

Add a new user as follows

```bash
useradd -m -k /usr/share/misc -G wheel -s /bin/zsh nikita
```

set the password on the user

```bash
passwd nikita
```

Add the wheel group to sudoers

```bash
EDITOR=nvim visudo
```

Uncomment this line:

```bash
%wheel ALL=(ALL:ALL) ALL
```

## Reboot

```bash
exit
umount -R /mnt
reboot now
```
