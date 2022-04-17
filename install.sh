#!/bin/bash
printf "[options]\nColor" | tee -a /etc/pacman.conf
ping -c 3 google.com
timedatectl set-ntp true
timedatectl status

if [[ $1 == "nvme" ]]; then
cfdisk /dev/nvme0n1
	# format
	mkfs.vfat /dev/nvme0n1p1
	swapoff /dev/nvme0n1p2
	mkswap /dev/nvme0n1p2
	swapon /dev/nvme0n1p2
	y|mkfs.ext4 /dev/nvme0n1p3
	y|mkfs.ext4 /dev/nvme0n1p4
	
	# mount
	mount /dev/nvme0n1p3 /mnt
	mkdir /mnt/boot /mnt/home
	mount /dev/nvme0n1p1 /mnt/boot
	mount /dev/nvme0n1p4 /mnt/home
	clear && lsblk -f
elif [[ $1 == "sata" ]]; then
cfdisk /dev/sda
	# format
	mkfs.vfat /dev/sda1
	swapoff /dev/sda2
	mkswap /dev/sda2
	swapon /dev/sda2
	y|mkfs.ext4 /dev/sda3
	y|mkfs.ext4 /dev/sda4
	
	# mount
	mount /dev/sda3 /mnt
	mkdir /mnt/boot /mnt/home
	mount /dev/sda1 /mnt/boot
	mount /dev/sda4 /mnt/home
	clear && lsblk -f
else
	pkill install.sh
	exec bash
fi


# mirrorlist
printf "Server = http://archlinux.cs.nctu.edu.tw/\$repo/os/\$arch\n" > /etc/pacman.d/mirrorlist
printf "Server = http://archlinux.ccns.ncku.edu.tw/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist

# install linux
pacstrap /mnt base linux linux-firmware sof-firmware intel-ucode
pacstrap /mnt git base-devel dhcpcd sudo pacman trash-cli

# fstab
genfstab -L /mnt > /mnt/etc/fstab chroot:arch-chroot /mnt

# host
printf "127.0.0.1		localhost\n::1			localhost\n127.0.0.1		ouch.localdomain      ouch" >> /mnt/etc/hosts
printf "ouch" > /mnt/etc/hostname

# systemd
claer && lsblk -f
bootctl install --esp-path /mnt/boot
printf "default arch\ntimeout 0" > /mnt/boot/loader/loader.conf
if [[ $1 == "nvme" ]]; then
printf "title ouch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=/dev/nvme0n1p3" > /mnt/boot/loader/entries/arch.conf
elif [[ $1 == "sata" ]]; then
printf "title ouch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=/dev/sda3" > /mnt/boot/loader/entries/arch.conf
fi
cat /mnt/boot/loader/entries/arch.conf

###chroot###
cp -r ~/ohmyarch /mnt
arch-chroot /mnt "/ohmyarch/script/chroot.sh"
###archiso###
cd / && umount -R /mnt
echo "done!"
