#!/bin/sh
# Debian torrent fetcher
#
# https://cdimage.debian.org/debian-cd/current-live
# https://cdimage.debian.org/debian-cd/current

if [ $# -eq 0 ]; then
	echo "Missing target directory"
	exit 1
fi
TARGET="$1"
if [ ! -d "$TARGET" ]; then
	if [ -e "$TARGET" ]; then
		echo "'$TARGET' already exists but is not a directory"
		exit 1
	fi
	mkdir -p "$TARGET"
	if [ ! -d "$TARGET" ]; then
		echo "Creating target directory failed"
		exit 1
	fi
fi

# CD images
BASE_CD_URL="https://cdimage.debian.org/debian-cd/current"
for arch in amd64; do
	for kind in bt-dvd; do
		torrent="$(curl -s "$BASE_CD_URL/$arch/$kind/" | grep -oE 'href="debian-[.0-9]+[-.a-zA-Z0-9]+\.torrent"' | sed -e 's/^href="//' -e 's/"$//' | sort -u)"

		if [ ! -e "$TARGET/$torrent" ] && [ ! -e "$TARGET/$torrent.added" ]; then
			echo "$torrent"
			echo $BASE_CD_URL$arch/$kind/$torrent
			curl -s "$BASE_CD_URL/$arch/$kind/$torrent" -o "$TARGET/$torrent"
		fi
	done
done
