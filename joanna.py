# /etc/init.d/joanna.py
### BEGIN INIT INFO
# Provides:          joanna.py
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Initialize machine
# Description:       Boot core pure data patch and translate udp port to i2c.
### END INIT INFO

from subprocess import call

call(['sh /home/pi/launcher.sh &'], shell=True)
