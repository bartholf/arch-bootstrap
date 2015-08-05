#!/bin/bash
echo "sv_SE.UTF-8 UTF-8
en_US.UTF-8 UTF-8" > /etc/locale.gen
echo 'LANG=sv_SE.UTF-8' > /etc/locale.conf
echo 'KEYMAP=sv-latin1' > /etc/vconsole.conf
echo 'karl' > /etc/hostname

locale-gen
export LANG=sv_SE.UTF-8
ln -s /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc --utc

mkinitcpio -p linux

pacman --noconfirm -S dosfstools intel-ucode bash-completion net-tools openssh

# Setup EFI Stub
bootctl --path=/boot install

echo "title     Arch Linux
linux           /vmlinuz-linux
initrd          /intel-ucode.img
initrd          /initramfs-linux.img
options         root=/dev/sda3 rw quiet" > /boot/loader/entries/arch.conf

echo "timeout 3
default arch"  > /boot/loader/loader.conf

passwd
