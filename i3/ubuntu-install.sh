#!/bin/sh
# i3 Ubuntu Installs
#   Penn Bauman <me@pennbauman.com>

if [ -z "$(command -v apt-get)" ]; then
	printf "\033[1;31m%s\033[0m\n" "APT not installed"
	exit 1
fi

printf "\033[1;32m%s\033[0m\n" "[i3 Ubuntu] Adding PPA for alacritty"
sudo add-apt-repository -y ppa:aslatter/ppa

packages="
alacritty
i3-wm
conky
polybar
redshift
rofi
picom
dunst
scrot
feh
"
printf "\033[1;32m%s\033[0m\n" "[i3 Ubuntu] Install Packages"
sudo apt-get -y install $packages


printf "\033[1;32m%s\033[0m\n" "[i3 Ubuntu] Installing i3lock-color (from source)"
sudo apt-get -y install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
mkdir -p "$HOME/.cache/dotfiles"
cd "$HOME/.cache/dotfiles"
if [ -e i3lock-color ]; then
	cd i3lock-color
	git pull --ff-only
else
	git clone https://github.com/Raymo111/i3lock-color.git
	cd i3lock-color
fi
./install-i3lock-color.sh

if [ -z $HOME/.cargo/env ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
. $HOME/.cargo/env

printf "\033[1;32m%s\033[0m\n" "[i3 Ubuntu] Installing xidlehook (from cargo)"
sudo apt-get -y install libx11-xcb-dev libxcb-screensaver0-dev
cargo install xidlehook --locked --bins

