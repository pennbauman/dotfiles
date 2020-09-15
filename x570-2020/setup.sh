#!/bin/bash
# Setup x570 Desktop
#   Fedora
#   i3

loc="$HOME/.dotfiles"
comp="x570-2020"

# Check install location and comp
source "$(dirname $BASH_SOURCE)/../install/check.sh" "$comp"

# Fedora Installs
bash ~/.dotfiles/install/fedora.sh
# i3 Fedora Installs
bash ~/.dotfiles/i3/fedora-install.sh
# General Configuration
bash ~/.dotfiles/install/configure.sh $comp
# i3 Configuration
bash ~/.dotfiles/i3/configure.sh $comp
# Folding@Home Configuration
bash ~/.dotfiles/install/fah.sh
