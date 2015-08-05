#!/bin/bash
loadkeys sv-latin1

echo "Initializing disks"
mkfs.vfat -F32 -I /dev/sda1

echo "Formatting /"
mkfs.ext4 /dev/sda2

echo "Mount disks"
mount /dev/sda2 /mnt
mkdir -p /mnt/{home,var,boot}
mkdir -p /mnt/opt/storage
mount /dev/sda1 /mnt/boot
mount /dev/sdc1 /mnt/home
mount /dev/sdb1 /mnt/opt/storage

echo "Server = http://ftp.lysator.liu.se/pub/archlinux/\$repo/os/\$arch
Server = http://ftp.availo.se/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

nano /mnt/etc/fstab
nano /mnt/etc/makepkg.conf

mkdir -p /mnt/install

cp ./*.sh /mnt/install
arch-chroot /mnt /install/20-chroot.sh

mkdir -p /mnt/etc/skel/{Downloads,Documents,Pictures}

# Temporary workaround for AUR moving to git
echo 'alias yaourt="yaourt --aur-url https://aur4.archlinux.org"' > /mnt/etc/skel/.bashrc

umount -R /mnt
