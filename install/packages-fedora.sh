#!/bin/sh
# PROGRAM INSTALLS

echo "Updating"
sudo dnf -y update

echo "Enabling copr Repositories"
sudo dnf copr enable opuk/pamixer 1> /dev/null
sudo dnf copr enable skidnik/termite 1> /dev/null
sudo dnf copr enable yaroslav/i3desktop 1> /dev/null
#sudo dnf copr enable pschyska/alacritty 1> /dev/null

echo "Enabling Google Chrome"
sudo dnf -y install fedora-workstation-repositories 1> /dev/null
sudo dnf config-manager --set-enabled google-chrome 1> /dev/null

packages="
i3-gaps
redshift
i3status
dmenu
feh
conky
rofi
polybar
stalonetray
picom
dunst
termite

openvpn
python3-pip
jq
latexmk
nodejs
texlive-latex
the_silver_searcher
pamixer

gcolor3
mpd
mpv
mpc
ncmpcpp
pavucontrol
zathura-pdf-mupdf
lxappearance
google-chrome-stable

clang
ffmpeg
gnuplot
htop
neofetch
neovim
perl-Image-ExifTool
qalc
ranger
tldr
zsh
"

echo "Install Packages"
sudo dnf -y install $packages 1> /dev/null

echo "Installing Flatpaks"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 1> /dev/null

flatpak -y install flathub org.gimp.GIMP 1> /dev/null
flatpak -y install flathub org.inkscape.Inkscape 1> /dev/null
flatpak -y install flathub com.valvesoftware.Steam 1> /dev/null
flatpak -y install flathub org.signal.Signal 1> /dev/null
flatpak -y install flathub com.mojang.Minecraft 1> /dev/null

echo "Setting Up ZSH"
sudo chsh -s /bin/zsh root
chsh -s /bin/zsh

echo "Install Desktop Programs?"
while true; do
    read -p "[y/n]: " n
	case $n in
		y|Y) sudo dnf -y install transmission-cli transmission-remote-gtk 1> /dev/null ;;
		n|N) break;;
		*) echo "Please enter 'y' or 'n'"
	esac
done


#kdeconnect
#scrot
#ttf-joypixels

#android-file-transfer
#android-tools
#jpegexiforient
#matcha-gtk-theme
#papirus-maia-icon-theme
