#!/bin/bash
# Start Xvfb (virtual display)
Xvfb :0 -screen 0 1024x768x16 &

# Start the VNC server with the virtual display created by Xvfb
x11vnc -display :0 -rfbport 5900 -passwd password &

# Start noVNC (with websockify to forward VNC traffic to the browser)
websockify --web /usr/share/novnc/ 6080 localhost:5900 &

# Start Openbox (lightweight window manager)
openbox-session &

# Launch WeChat via Wine
wine "C:\\Program Files\\WeChat\\WeChat.exe"

