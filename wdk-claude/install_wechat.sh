#!/bin/bash
set -e

# Check if WeChat is already installed
if [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/Tencent/WeChat/WeChat.exe" ]; then
    echo "Installing WeChat..."
    wine /path/to/WeChatSetup.exe
else
    echo "WeChat is already installed."
fi

# Start WeChat
wine "$WINEPREFIX/drive_c/Program Files (x86)/Tencent/WeChat/WeChat.exe"
