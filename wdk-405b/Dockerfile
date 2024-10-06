# Use Alpine Linux as the base image
FROM alpine:latest

# Set locale to UTF-8
RUN locale-gen zh_CN.UTF-8
ENV LANG=zh_CN.UTF-8

# Install Wine and winetricks
RUN apk add --no-cache wine winetricks

# Install Windows font
COPY fonts /usr/share/fonts/

# Set Wine environment variables
ENV WINEPREFIX=/root/.wine
ENV WINEARCH=win32

# Initialize Wine
RUN winecfg

# Install box32 and box64 for ARM64 support
RUN apk add --no-cache box32 box64
ENV BOX32_ENABLE=1
ENV BOX64_ENABLE=1

# Install mingw-w64 for non-VC
# RUN apk add --no-cache mingw-w64

# Install Python using Wine
# RUN wine python-3.9.5.exe

# Install Vim and Git
RUN apk add --no-cache vim git

# Install X11 and xdotool
RUN apk add --no-cache x11
RUN apk add --no-cache xdotool

# Install NoVNC
RUN apk add --no-cache novnc

# Set NoVNC environment variables
ENV NOVNC_PORT=6080
ENV NOVNC_PASSWORD=your_password

# Install TightVNC
RUN apk add --no-cache tightvnc

# Create a directory for Win32 apps
RUN mkdir -p /root/.wine/drive_c/Program\ Files/

# Copy shell scripts
COPY start_win32_app.sh /root/
COPY start_vnc.sh /root/

ENTRYPOINT ["/root/start_win32_app.sh", "${WIN32_APP}"]
