#!/bin/sh

# Start the VNC server and NoVNC service
/root/start_vnc.sh &

# Start the Win32 app using Wine
wine "/root/.wine/drive_c/Program Files/$1/$1.exe"

