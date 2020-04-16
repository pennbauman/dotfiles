#/bin/sh
# bash scripts/install.sh [quick]

# SET AND CHECK LCOATION
loc="$HOME/.i3-config"
if [[ $(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd) != $loc ]]; then
	echo "Configuration not properly located, it should be at ~/.i3-config/"
	exit 1
fi

# GET POSSIBLE COMPUTERS
computers=()
for f in $loc/*; do
	if [ -d $f ]; then
		d=$(basename $f)
		if [[ $d != "configs" && $d != "scripts" ]]; then
			#echo $d
			computers+=($d)
		fi
	fi
done

# SELECT COMPUTER OR THROW ERROR
if (( $# > 0 )); then
	for c in "${computers[@]}"; do
		if [[ $1 == $c ]]; then
			comp="$1"
		fi
	done
	if [[ $comp == "" ]]; then
		echo "Unknown computer provided, options:"
		for c in "${computers[@]}"; do
			echo "  $c"
		done
		exit 1
	fi
else
	echo "A computer must be provided, options:"
	for c in "${computers[@]}"; do
		echo "  $c"
	done
	exit 1
fi

# REMOVE EXISTING CONFIGS
rm -f $HOME/.config/i3/config
rm -f $HOME/.config/rofi/config
rm -f $HOME/.config/termite/config
rm -f $HOME/.config/dunst/dunstrc
rm -f $HOME/.config/ncmpcpp/config
rm -f $HOME/.config/ncmpcpp/bindings
rm -f $HOME/.config/polybar/config
rm -f $HOME/.config/mpd/mpd.conf
rm -f $HOME/.config/zathura/zathurarc
rm -rf $HOME/.config/ranger
rm -f $HOME/.zshrc
rm -f $HOME/.profile
rm -f $HOME/.stalonetrayrc
rm -f $HOME/.config/nvim/init.vim
rm -f $HOME/.local/share/nvim/site/colors/maia-custom.vim
rm -f $HOME/.local/share/nvim/site/autoload/airline/themes/maia_custom.vim
rm -f $HOME/.config/user-dirs.dirs
rm -f $HOME/.zsh-dirs

rm -f $HOME/.local/share/fonts/material_design_icons.ttf
sudo rm -rf /etc/X11/xorg.conf.d
sudo chattr -i /etc/resolv.conf
sudo rm -f /etc/resolv.conf
sudo rm -f /root/.zshrc
echo "Configs Cleared"

# LINK NEW CONFIGS
ln -s $loc/$comp/config $HOME/.config/i3/config
ln -s $loc/configs/rofi-config $HOME/.config/rofi/config
ln -s $loc/configs/termite-config $HOME/.config/termite/config
ln -s $loc/configs/dunstrc $HOME/.config/dunst/dunstrc
ln -s $loc/configs/ncmpcpp-config $HOME/.config/ncmpcpp/config
ln -s $loc/configs/ncmpcpp-bindings $HOME/.config/ncmpcpp/bindings
ln -s $loc/configs/polybar $HOME/.config/polybar/config
ln -s $loc/configs/mpd.conf $HOME/.config/mpd/mpd.conf
ln -s $loc/configs/zathurarc $HOME/.config/zathura/zathurarc
ln -s $loc/configs/ranger $HOME/.config/ranger
ln -s $loc/configs/zshrc $HOME/.zshrc
ln -s $loc/configs/profile $HOME/.profile
ln -s $loc/configs/stalonetrayrc $HOME/.stalonetrayrc
ln -s $loc/configs/nvim.init.vim $HOME/.config/nvim/init.vim
ln -s $loc/configs/maia-custom.vim $HOME/.local/share/nvim/site/colors/maia-custom.vim
ln -s $loc/configs/airline-maia_custom.vim $HOME/.local/share/nvim/site/autoload/airline/themes/maia_custom.vim
ln -s $loc/configs/user-dirs.dirs $HOME/.config/user-dirs.dirs
ln -s $loc/$comp/zsh-dirs $HOME/.zsh-dirs

if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp $loc/configs/material_design_icons.ttf $HOME/.local/share/fonts/material_design_icons.ttf
sudo cp -r $loc/$comp/xorg /etc/X11/xorg.conf.d
sudo cp $loc/configs/resolv.conf /etc/
sudo chattr -i /etc/resolv.conf
sudo cp $loc/configs/zshrc-root /root/.zshrc
echo "Configs Linked"


# CREATE ~/.bin
if [ ! -d $HOME/.bin ]; then
	mkdir $HOME/.bin
fi
chmod 755 $loc/scripts/*
for f in $loc/scripts/*; do
	rm -f $HOME/.bin/${f:$(echo "$loc/scripts" | wc -c)}
	ln -s $f $HOME/.bin/${f:$(echo "$loc/scripts" | wc -c)}
done
gcc -O2 $loc/scripts/brightcalc.c -o $HOME/.bin/brightcalc
rm -rf $HOME/.bin/*.c
echo "~/.bin/ created"


# EDIT TERMITE GTK CSS
if [ $(cat "$HOME/.config/gtk-3.0/gtk.css" | grep ".termite" | wc -l) == 0 ]; then 
    echo ".termite {" >> $HOME/.config/gtk-3.0/gtk.css
    echo "    padding: 8px;" >> $HOME/.config/gtk-3.0/gtk.css
    echo "}" >> $HOME/.config/gtk-3.0/gtk.css
    echo "gtk.css Updated"
else 
    echo "Termite already styled in gtk.css"
fi
