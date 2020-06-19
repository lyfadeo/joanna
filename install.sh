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
git clone https://github.com/lyfadeo/joanna

echo "Startup setup"
cp launcher.sh /home/pi/launcher.sh
cp joanna.py /etc/init.d/joanna.py
chmod +x /etc/init.d/joanna.py
update-rc.d /etc/init.d/joanna.py defaults

echo "Server setup"
mkdir /home/pi/partage
chmod 777 /home/pi/partage
cp samba/smb.conf /etc/samba/smb.conf

echo "Core setup"
cp puredata/core.pd /home/pi/core.pd
cp puredata/player.pd /home/pi/player.pd
cp puredata/custom.pd /home/pi/partage/custom.pd
cp puredata/index.txt /home/pi/partage/index.txt

echo "Hardware setup"
cd pdwiringpi
make
cd
cp pdwiringPi/pdwiringPi/wiringPi.pd_linux wiringPi.pd_linux
sh lcd/install.sh
