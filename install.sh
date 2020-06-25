#!/bin/bash
if [ "$(id -u)" != "0" ]; then
	echo "Please re-run as sudo."
	exit 1
fi

echo "Installing prerequisites"
apt update
apt upgrade
apt install samba puredata wiringpi git -y

echo "Getting files"
git clone https://github.com/the-raspberry-pi-guy/lcd
git clone https://github.com/garthz/pdwiringPi

echo "Startup setup"
cp launcher.sh /home/pi/launcher.sh
cp joannaboot.py /etc/init.d/joannaboot.py
chmod +x /etc/init.d/joannaboot.py
update-rc.d /etc/init.d/joannaboot.py defaults

echo "Server setup"
mkdir /home/pi/partage
chmod 777 /home/pi/partage
cp smb.conf /etc/samba/smb.conf

echo "Core setup"
cp core.pd /home/pi/core.pd
cp player.pd /home/pi/player.pd
cp custom.pd /home/pi/partage/custom.pd
cp index.txt /home/pi/partage/index.txt

echo "Hardware setup"
cd pdwiringpi
make
cd
cp pdwiringPi/pdwiringPi/wiringPi.pd_linux wiringPi.pd_linux
sh lcd/install.sh
