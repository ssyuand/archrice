ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
hwclock --systohc
printf "LANG=zh_TW.UTF-8\n" >> /etc/locale.conf
printf "LANG=en_US.UTF-8" >> /etc/locale.conf
echo zh_TW.UTF-8 UTF-8 | sudo tee -a /etc/locale.gen
echo en_US.UTF-8 UTF-8 | sudo tee -a /etc/locale.gen
locale-gen

# wheel ALL=(ALL) ALL
echo '%Wheel ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo

# network
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

#open rootwq
echo -e "0\n0\n" | passwd
useradd -mG wheel syuan
echo "enter your passwd syuand:"
echo -e "0\n0\n" | passwd syuan
usermod -aG wheel,audio,video,optical,storage syuan

cp -r /ohmyarch /home/syuan
chown -R syuan /home/syuan/ohmyarch/*
