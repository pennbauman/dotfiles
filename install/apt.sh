#!/bin/sh
# General APT Installs
#   Penn Bauman <me@pennbauman.com>
#   https://github.com/pennbauman/dotfiles

if [ -z "$(command -v apt-get)" ]; then
	printf "\033[1;31m%s\033[0m\n" "APT not installed"
	exit 1
fi

printf "\033[1;32m%s\033[0m\n" "[APT] Updating"
sudo apt-get update
sudo apt-get -y upgrade

packages="
clang
curl
feh
ffmpeg
flatpak
gcc
git-email
gnuplot
htop
imagemagick
jq
libimage-exiftool-perl
mpc
mpd
mpv
ncmpcpp
ncmpcpp
neovim
nethogs
python3-pip
qalc
ranger
rclone
software-properties-common
ssmtp
tldr
zathura
zsh
"
printf "\033[1;32m%s\033[0m\n" "[APT] Installing Packages"
sudo apt-get -y install --no-install-recommends $packages $@
