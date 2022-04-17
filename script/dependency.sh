#!/bin/bash
install_dependency() {
yes | sudo pacman -S
	tools=(
	"alacritty"
	"ttf-droid"
	"firefox"
	"figlet"
	"fcitx5"
	"fcitx5-gtk"
	"fcitx5-chewing"
	"fcitx5-config-qt"
	"rofi"
	"ninja"
	"neovim"
	"nerd-fonts"
	"git"
	"htop"
	"trash-cli"
	"xorg-server"
	"xorg-xsetroot"
	"xorg-xinit"
	"xorg-xrandr"
	"xorg-setxkbmap"
	"xclip"
	"sxhkd"
	"libxinerama"
	"libxft"
	"feh"
	"wget"
	"uthash"
	"meson"
	"libev"
	"libconfig"
	)
for tool in ${tools[@]}; do
	sudo pacman -S --needed --noconfirm $tool
done
xrandr -s 1920x1080

# fcitx
fcitx5 &
printf "export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
" > ~/.xprofile
git clone https://github.com/catppuccin/fcitx5.git ~/library/fcitx5
mkdir -p ~/.local/share/fcitx5/themes/
cp -r ~/library/fcitx5/Catppuccin ~/.local/share/fcitx5/themes
echo "Theme=Catppuccin" > ~/.config/fcitx5/conf/classicui.conf
}

aur() {
# AUR
mkdir ~/library
echo "AUR" | figlet
sudo git clone https://aur.archlinux.org/yay.git ~/library/yay
sudo chown -R syuan ~/library/*
cd ~/library/yay && makepkg -si --noconfirm
}
