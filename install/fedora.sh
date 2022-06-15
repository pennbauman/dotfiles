#!/bin/sh
# General Fedora Installs
#   Penn Bauman <me@pennbauman.com>

message() {
	if [ -z $BASH_SOURCE ]; then
		echo "\033[1;32m$1\033[0m"
	else
		echo -e "\033[1;32m$1\033[0m"
	fi
}

message "Configure DNF"
echo "max_parallel_downloads=8" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf


message "Updating"
sudo dnf -y upgrade

message "Enabling RPM Fusion"
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

message "Enabling Google Chrome"
sudo dnf -y install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome

packages="
android-tools
ccls
clang
cronie
ffmpeg
gcolor3
gnuplot
google-chrome-stable
htop
jq
kdeconnectd
latexmk
mpc
mpd
mpv
ncmpcpp
neofetch
neovim
nethogs
nodejs
openvpn
pavucontrol
perl-Image-ExifTool
python3-pip
qalc
ranger
rclone
sassc
texlive-latex
texlive-scheme-medium
the_silver_searcher
tldr
util-linux-user
zathura
zathura-plugins-all
zathura-zsh-completion
zsh
"
if [ $# -ne 0 ]; then
	packages="$packages $(cat "$1")"
fi
message "Installing Packages"
sudo dnf -y install $packages --skip-broken


message "Installing Flatpaks"
flatpaks="
org.gimp.GIMP
org.inkscape.Inkscape
com.valvesoftware.Steam
org.signal.Signal
com.mojang.Minecraft
com.discordapp.Discord
"
sudo dnf -y install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete --user fedora
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak -y install flathub-beta com.google.Chrome
flatpak -y install flathub $flatpaks

message "Linking ~/.minecraft/"
mkdir -p $HOME/.var/app/com.mojang.Minecraft/data/minecraft/saves
mkdir -p $HOME/.var/app/com.mojang.Minecraft/data/minecraft/resourcepacks
rm -rf $HOME/.minecraft
ln -fs $HOME/.var/app/com.mojang.Minecraft/data/minecraft $HOME/.minecraft

message "Installing Rust (with rustup)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

message "Installing gotop"
mkdir -p $HOME/.bin
git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop
/tmp/gotop/scripts/download.sh
mv gotop $HOME/.local/bin
