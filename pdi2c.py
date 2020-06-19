#import os
import sys
import socket
import time

sys.path.insert(1, '/home/pi/lcd')
import lcddriver

display = lcddriver.lcd()

def pdreceive(port):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(('localhost', port))
    s.listen(1)

    while True:
        conn, addr = s.accept()
        for line in conn.makefile():
            yield line
        conn.close()
    s.close()

print("port 13001 actif. normalement ca marche.")

for message in pdreceive(13001):

      recstr=message.strip(';\n')
      display.lcd_clear()
      display.lcd_display_string("+recstr+", 1)

