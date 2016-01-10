#!/bin/sh
echo "[archlinuxfr]
# The French Arch Linux communities packages.
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

pacman -Syu
pacman -S --noconfirm yaourt
pacman -S --noconfirm nvidia pangox-compat
#pacman -S --noconfirm xf86-video-intel
pacman -S --noconfirm xorg-server xorg-xinit xorg-server-utils
pacman -S --noconfirm xfce4 xfce4-goodies
pacman -S --noconfirm sudo ttf-dejavu networkmanager network-manager-applet
pacman -S --noconfirm gvfs gvfs-afp gvfs-gphoto2 gvfs-afc gvfs-goa gvfs-mtp gvfs-smb
pacman -S --noconfirm polkit-gnome gnome-keyring
pacman -S --noconfirm pulseaudio pavucontrol
pacman -S --noconfirm gst-libav gst-plugins-good gst-plugins-bad gst-plugins-ugly
pacman -S --noconfirm virtualbox virtualbox-host-modules virtualbox-host-dkms
pacman -S --noconfirm ttf-inconsolata ttf-ubuntu-font-family ttf-droid
pacman -R --noconfirm mousepad
pacman -S --noconfirm gedit
#pacman -S --noconfirm firefox flashplugin

systemctl enable NetworkManager.service
systemctl enable dkms.service

useradd -m -G wheel,vboxusers,storage,lp,power -s /bin/bash rib
echo "Password for rib"
passwd rib

visudo

echo "vboxdrv
vboxnetflt" > /etc/modules-load.d/virtualbox.conf

#pacman -S --noconfirm gstreamer0.10-good-plugins gstreamer0.10-bad-plugins gstreamer0.10-ugly-plugins gstreamer0.10-ffmpeg
#yaourt -S --noconfirm xfce-theme-greybird-git adduser
#yaourt -S --noconfirm xfce4-volumed-pulse
