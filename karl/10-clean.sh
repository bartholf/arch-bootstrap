#!/bin/bash

###
# sda1 EF00 EFI
# sda2 8200 Linux Swap
# sda3 8300 /
###

loadkeys sv-latin1

echo "Initializing disks"
mkfs.vfat -F32 -I /dev/sda1

echo "Formatting /"
mkfs.ext4 /dev/sda3

mkswap /dev/sda2
swapon /dev/sda2

echo "Mount disks"
mount /dev/sda3 /mnt
mount /dev/sda1 /mnt/boot

echo "Server = http://ftp.lysator.liu.se/pub/archlinux/\$repo/os/\$arch
Server = http://ftp.availo.se/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

nano /mnt/etc/fstab
nano /mnt/etc/makepkg.conf

mkdir -p /mnt/install

cp ./20-chroot.sh /mnt/install
arch-chroot /mnt /install/20-chroot.sh

mkdir -p /mnt/etc/skel/{Downloads,Documents,Pictures}

umount /mnt{/boot}
