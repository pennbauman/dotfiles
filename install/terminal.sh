#!/bin/sh
# Configure for Terminal Use
#   Penn Bauman <me@pennbauman.com>

loc="$HOME/.dotfiles"
comp=$1

# Check install location and comp
. "$(dirname $(readlink -f $0))/check.sh" "$comp"

# Set ENV variables
if [ -z $XDG_CONFIG_HOME ]; then
	XDG_CONFIG_HOME=$HOME/.config
fi
if [ -z $XDG_DATA_HOME ]; then
	XDG_DATA_HOME=$HOME/.local/share
fi


# Making necessary directories
rm -rf $HOME/.config/ranger
mkdir -p $XDG_CONFIG_HOME/git
mkdir -p $XDG_CONFIG_HOME/nvim
mkdir -p $XDG_DATA_HOME/nvim/site/colors
mkdir -p $XDG_DATA_HOME/nvim/site/autoload/airline/themes

message "Linking Terminal Configs"
ln -fs $loc/configs/gitconfig $XDG_CONFIG_HOME/git/config
echo "*~
*.swp" > $XDG_CONFIG_HOME/git/ignore
ln -fs $loc/configs/ranger $XDG_CONFIG_HOME/ranger
ln -fs $loc/configs/profile $HOME/.profile
ln -fs $loc/configs/aliasrc $HOME/.aliasrc
ln -fs $loc/configs/bashrc $HOME/.bashrc
ln -fs $loc/configs/zshrc $HOME/.zshrc
ln -fs $loc/configs/vimrc $HOME/.vimrc
ln -fs $loc/configs/nvim.init.lua $XDG_CONFIG_HOME/nvim/init.lua
ln -fs $loc/configs/maia-custom.vim $XDG_DATA_HOME/nvim/site/colors/maia-custom.vim
ln -fs $loc/configs/airline-maia_custom.vim $XDG_DATA_HOME/nvim/site/autoload/airline/themes/maia_custom.vim

message "Setting Up Zsh"
if [ "$(basename $SHELL)" != "zsh" ]; then
	chsh -s /usr/bin/zsh
fi
if [ -f $loc/$comp/zsh-dirs ]; then
	ln -fs $loc/$comp/zsh-dirs $HOME/.zsh-dirs
fi
