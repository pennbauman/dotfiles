#!/bin/bash
# Configure i3

loc="$HOME/.dotfiles"
comp="$1"

# Check install location and comp
source "$(dirname $BASH_SOURCE)/../install/check.sh" "$comp"

# Set ENV variables
if [ -z $XDG_CONFIG_HOME ]; then
	XDG_CONFIG_HOME=$HOME/.config
fi
if [ -z $XDG_DATA_HOME ]; then
	XDG_DATA_HOME=$HOME/.local/share
fi

# Making necessary directories
mkdir -p $XDG_CONFIG_HOME/sway
mkdir -p $XDG_CONFIG_HOME/waybar

message "Linking Configs"
ln -fs $loc/$comp/sway-config $XDG_CONFIG_HOME/sway/config
ln -fs $loc/sway/configs/waybar $XDG_CONFIG_HOME/waybar/config
ln -fs $loc/sway/configs/waybar.css $XDG_CONFIG_HOME/waybar/style.css

message "Adding Font"
cp -f $loc/sway/configs/material_design_icons.ttf $XDG_DATA_HOME/fonts/material_design_icons.ttf

# Adding local directory
mkdir -p $loc/.local

message "Compiling brightcalc.c"
gcc -O2 $loc/sway/scripts/brightcalc.c -o $loc/.local/brightcalc