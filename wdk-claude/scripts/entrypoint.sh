#!/bin/bash
set -e

# Start Xvfb
Xvfb :99 -screen 0 1024x768x16 &
sleep 1

# Start VNC server (optional, for remote viewing)
x11vnc -display :99 -forever -nopw &

# Run WeChat installation/startup script
/usr/local/bin/install_wechat.sh
