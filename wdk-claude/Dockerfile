# Stage 1: Base image
FROM --platform=$TARGETPLATFORM debian:bullseye-slim AS base

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DISPLAY=:99
ENV WINEDEBUG=-all

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    software-properties-common \
    xvfb \
    x11vnc \
    xdotool \
    vim \
    git \
    locales \
    python3 \
    python3-pip \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Install Wine
RUN dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    apt-key add winehq.key && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' && \
    apt-get update && \
    apt-get install -y --install-recommends winehq-stable

# Install Winetricks
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    chmod +x winetricks && \
    mv winetricks /usr/local/bin

# Install Box86 and Box64 for ARM64 support
RUN if [ "$(uname -m)" = "aarch64" ]; then \
    apt-get update && \
    apt-get install -y cmake gcc-arm-linux-gnueabihf && \
    git clone https://github.com/ptitSeb/box86 && \
    cd box86 && mkdir build && cd build && \
    cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
    make -j$(nproc) && make install && \
    cd ../.. && \
    git clone https://github.com/ptitSeb/box64 && \
    cd box64 && mkdir build && cd build && \
    cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
    make -j$(nproc) && make install; \
    fi

# Copy Windows fonts (you need to provide these)
COPY ./windows_fonts /usr/share/fonts/windows

# Set up scripts
COPY scripts/init_wine.sh /usr/local/bin/
COPY scripts/install_wechat.sh /usr/local/bin/
COPY scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_wine.sh \
    /usr/local/bin/install_wechat.sh \
    /usr/local/bin/entrypoint.sh

# Stage 2: Wine initialization
FROM base AS wine_init

# Initialize Wine
RUN /usr/local/bin/init_wine.sh

# Stage 3: Final image
FROM wine_init AS final

# Install Python in Wine (optional, remove if not needed)
# RUN wine python-3.9.7-amd64.exe /quiet InstallAllUsers=1 PrependPath=1

# Expose noVNC port
EXPOSE 6080

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
