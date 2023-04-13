#!/bin/sh
# Install and Setup transmission-daemon
#   Penn Bauman <me@pennbauman.com>
#   https://github.com/pennbauman/dotfiles

if [ -z "$(command -v transmission-daemon)" ]; then
	printf "\033[1;31m%s\033[0m\n" "transmission-daemon not installed"
	exit 1
fi

SYSTEMD="/etc/systemd/system/transmission-daemon.service.d"
VAR="/var/lib/transmission-daemon"
HERE="$(dirname $(readlink -f $0))"

# Pause service
sudo systemctl stop transmission-daemon

printf "\033[1;32m%s\033[0m\n" "[transmission-daemon] Overriding systemd service"
sudo mkdir -p $SYSTEMD
sudo cp $HERE/systemd-override.conf $SYSTEMD/override.conf
sudo sed -i "s/USER/$USER/" $SYSTEMD/override.conf

printf "\033[1;32m%s\033[0m\n" "[transmission-daemon] Configuring daemon"
# Create working directories
sudo mkdir -p $VAR/config $VAR/watch $VAR/downloads $VAR/partial
sudo chown -R $USER:$USER $VAR
# Configure daemon
touch $VAR/config/settings.json
if [ -z "$(grep -E -- '-daemon\/watch",$' "$VAR/config/settings.json")" ]; then
	cp $HERE/settings.json $VAR/config/settings.json
	read -p "RPC Password: " input
	sudo sed -i "s/PASSWORD/$input/" $VAR/config/settings.json
fi

printf "\033[1;32m%s\033[0m\n" "[transmission-daemon] Configuring cron backup script"
sudo cp $HERE/backup.cron /etc/cron.daily/transmission-daemon-backup

printf "\033[1;32m%s\033[0m\n" "[transmission-daemon] Starting service"
sudo systemctl daemon-reload
sudo systemctl enable transmission-daemon
sudo systemctl start transmission-daemon