# First stage: build box86 and box64
FROM debian:bookworm-slim AS build

ENV DEBIAN_FRONTEND="noninteractive"

# Install libraries needed to compile box86 and box64
RUN dpkg --add-architecture armhf \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests git wget curl cmake python3 build-essential gcc-arm-linux-gnueabihf libc6-dev-armhf-cross libc6:armhf libstdc++6:armhf ca-certificates

WORKDIR /root

# Build box86
RUN git clone https://github.com/ptitSeb/box86 \
    && mkdir box86/build \
    && cd box86/build \
    && cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    && make -j$(nproc) \
    && make install DESTDIR=/box

# Build box64
RUN git clone https://github.com/ptitSeb/box64 \
    && mkdir box64/build \
    && cd box64/build \
    && cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    && make -j$(nproc) \
    && make install DESTDIR=/box

# Second stage: prepare the runtime environment
FROM debian:bookworm-slim

# Copy compiled box86 and box64 binaries
COPY --from=build /box /

# Install runtime dependencies and VNC/GUI tools
RUN dpkg --add-architecture armhf \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget curl libc6:armhf libstdc++6:armhf ca-certificates \
       git net-tools supervisor fluxbox xterm x11vnc novnc xvfb xdotool gnupg2 software-properties-common sudo \
       ttf-wqy-microhei locales procps vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir ~/.vnc && x11vnc -storepasswd vncpass ~/.vnc/passwd \
    && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen

# Setup user environment
RUN useradd -m app && usermod -aG sudo app && echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set environment variables for display and locale
ENV DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=720 \
    DISPLAY=:0.0 \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    WINEPREFIX=/home/app/.wine


# Copy any additional configuration files
COPY root/ /

# Expose VNC and HTTP for noVNC
EXPOSE 8080

# Install wine (custom installation script)
COPY install-wine.sh /
RUN bash /install-wine.sh && rm /install-wine.sh
# Install box wrapper for wine
COPY wrap-wine.sh /
RUN bash /wrap-wine.sh && rm /wrap-wine.sh

# Switch to the app user
USER app

WORKDIR /home/app


# Initialize the GUI environment
RUN bash -c 'nohup /entrypoint.sh 2>&1 &' && sleep 6 && sudo rm /tmp/.X0-lock

# Default entry point for starting GUI and VNC
ENTRYPOINT ["/entrypoint.sh"]

