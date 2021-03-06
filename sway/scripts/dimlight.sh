#!/bin/bash

loc="$HOME/.dotfiles/.local"

current=$(sed '1q;d' $loc/dimbright)
echo "$current"

new=$($loc/brightcalc $current $1)
echo $new

echo "$new" > $loc/dimbright
prev=$(pgrep gammastep)
#redshift -P -o -r -b "$new:$new"
gammastep -r -b $new -l "38:-78" &
kill $prev
