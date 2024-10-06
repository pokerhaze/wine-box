# Step 1: Base image with required packages
FROM debian:bullseye-slim AS base

# Set locale to support UTF-8 (Chinese)
RUN apt-get update && \
    apt-get install -y locales && \
    sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=zh_CN.UTF-8 && \
    apt-get clean

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# Install essentials: git, vim, fonts, and dependencies
RUN apt-get update && \
    apt-get install -y git vim xdotool x11-utils fontconfig locales && \
    apt-get install -y --no-install-recommends wget gnupg2 software-properties-common xvfb x11vnc novnc websockify openbox && \
    apt-get clean

# Install Wine (latest version)
RUN dpkg --add-architecture arm64 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key -O /etc/apt/trusted.gpg.d/winehq.key && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' && \
    apt-get update && \
    apt-get install -y winehq-stable winetricks

# Install Windows fonts
RUN apt-get install -y ttf-mscorefonts-installer && fc-cache -f -v

# Install box64 and box32 for multi-platform ARM support
RUN apt-get install -y box64 box86

# Set up Wine to work properly in the container
RUN winecfg && \
    winetricks corefonts && \
    winetricks settings fontsmooth=rgb

# Install Python via Wine
RUN wget https://www.python.org/ftp/python/3.9.1/python-3.9.1-amd64.exe -O python-installer.exe && \
    wine python-installer.exe /quiet InstallAllUsers=1 PrependPath=1

# Install WeChat (Note: Modify the path to the installer if needed)
RUN wget https://dldir1.qq.com/weixin/Windows/WeChatSetup.exe -O /wechat-installer.exe && \
    wine /wechat-installer.exe /silent

# Create a VNC password
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# Xvfb setup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the VNC and noVNC ports
EXPOSE 5900 6080

# ENTRYPOINT for running WeChat via noVNC
ENTRYPOINT ["/start.sh"]

