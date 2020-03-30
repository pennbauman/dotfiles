#/bin/sh
# i3 Exit

function pacmaner {
	if [ ! -z $(yay -Qu) ]; then
		echo "$(yay -Qu | wc -l) packages ready to update"
		while true; do
			read -p "Would you like to update? [y/n] " $answer
			case $answer in
				y|Y) yay 
					break;;
				n|N) break;; 
				*) echo 'Please enter "y" or "n"';;
			esac
		done
	fi
}

echo "i3 System"
echo "  [s] shutdown"
echo "  [r] reboot"
echo "  [e] exit i3"
#echo "  [z] sleep"
echo "  [c] cancel"
while true; do 
    read -p ": " t
	case $t in
		s) pacmaner
			shutdown
			exit 0;;
		r) pacmaner
			reboot
			exit 0;;
		e) i3-msg exit
			exit 0;;
		#z) bash ~/.bin/i3locker.sh
			#xset dpms force off
			#i3exit suspend
			#exit 0;;
		c) exit 0;;
		*) echo " Invalid input."
	esac
done
