#!/bin/bash
set -e

# Start Xvfb
Xvfb :99 -screen 0 1024x768x16 &

# Wait for Xvfb to be ready
sleep 2

# Initialize Wine
WINEARCH=win64 WINEPREFIX=/root/.wine wine wineboot --init

# Install necessary components with Winetricks
winetricks -q msxml6 dotnet48 vcrun2019

# Additional Wine configuration if needed
