#!/bin/sh

# Start the VNC server
tightvncserver :1 -geometry 1024x768 -depth 24 &

# Start the NoVNC service
novnc --listen 6080 --vnc localhost:5900 --password your_password &

