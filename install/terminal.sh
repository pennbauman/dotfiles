#!/bin/sh
# Configure for Terminal Use
#   Penn Bauman <me@pennbauman.com>
#   https://github.com/pennbauman/dotfiles
LOC="$HOME/.dotfiles"

# Check install location
$(dirname $(readlink -f $0))/check.sh "none"
if [ $? -ne 0 ]; then
	exit 1
fi

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
mkdir -p $XDG_CONFIG_HOME/fish
mkdir -p $XDG_CONFIG_HOME/nvim
mkdir -p $XDG_CONFIG_HOME/lf
mkdir -p $XDG_CONFIG_HOME/zellij
mkdir -p $XDG_DATA_HOME/nvim/site/colors
mkdir -p $XDG_DATA_HOME/nvim/site/autoload/airline/themes

printf "\033[1;32m%s\033[0m\n" "Linking Terminal Configs"
ln -fs $LOC/configs/git/config $XDG_CONFIG_HOME/git/config
ln -fs $LOC/configs/git/ignore $XDG_CONFIG_HOME/git/ignore
cp $LOC/configs/git/email.sample $XDG_CONFIG_HOME/git/email.sample
ln -fs $LOC/configs/ranger -T $XDG_CONFIG_HOME/ranger
ln -fs $LOC/configs/profile $HOME/.profile
ln -fs $LOC/configs/aliasrc $HOME/.aliasrc
ln -fs $LOC/configs/bashrc $HOME/.bashrc
ln -fs $LOC/configs/zshrc $HOME/.zshrc
ln -fs $LOC/configs/fish-config.fish $HOME/.config/fish/config.fish
ln -fs $LOC/configs/vimrc $HOME/.vimrc
ln -fs $LOC/configs/nvim.init.lua $XDG_CONFIG_HOME/nvim/init.lua
ln -fs $LOC/configs/maia-custom.vim $XDG_DATA_HOME/nvim/site/colors/maia-custom.vim
ln -fs $LOC/configs/maia-custom-airline.vim $XDG_DATA_HOME/nvim/site/autoload/airline/themes/maia_custom.vim
ln -fs $LOC/configs/lfrc $XDG_CONFIG_HOME/lf/lfrc
ln -fs $LOC/configs/lfcolors $XDG_CONFIG_HOME/lf/colors
ln -fs $LOC/configs/zellij.kdl $XDG_CONFIG_HOME/zellij/config.kdl
ln -fs $LOC/configs/zellij-layouts -T $XDG_CONFIG_HOME/zellij/layouts

# Setup fish if available
if [ -f /usr/bin/fish ]; then
	printf "\033[1;32m%s\033[0m\n" "Enabling fish"
	if [ "$(basename $SHELL)" != "fish" ]; then
		chsh -s /usr/bin/fish
	fi
fi
