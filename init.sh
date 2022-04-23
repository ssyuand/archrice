#!/bin/bash
sudo printf "\n[options]\nColor" | sudo tee -a /etc/pacman.conf
sudo chown -R syuan /home/syuan/ohmyarch
sudo chmod u+x /home/syuan/ohmyarch

DIR=$(pwd)
. "$DIR/script/dependency.sh"
. "$DIR/script/desktop.sh"
. "$DIR/script/neovim.sh"

config_mirror () {
    PACMAN_MIRROR=$(cat /etc/pacman.d/mirrorlist)
    if [[ $PACMAN_MIRROR != *"nctu"* ]]; then
        sudo echo 'Server = https://archlinux.cs.nctu.edu.tw/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    fi
	sudo pacman -Sy
}

# config all shit
if [[ $1 == "dependency" ]]; then
	install_dependency
elif [[ $1 == "desktop" ]]; then
	install_desktop
elif [[ $1 == "neovim" ]]; then
	install_neovim
elif [[ $1 == "lsp" ]]; then
	install_ls
elif [[ $1 == "aur" ]]; then
	install_aur
elif [[ $1 == "wireless" ]]; then
	install_wireless
else
	config_mirror
	install_dependency
	install_desktop
	install_neovim
fi
