FROM --platform=linux/amd64 ubuntu:24.04 AS base
LABEL maintainer="Tim Chaubet"
ARG DEBIAN_FRONTEND="noninteractive"

# 1. Install base dependencies and setup locales
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        software-properties-common \
        tzdata \
        wget \
        ca-certificates \
        locales && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# 2. Setup WineHQ and i386
FROM base AS wine-setup
RUN mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        winehq-stable && \
    rm -rf /var/lib/apt/lists/*

# 3. Install remaining dependencies and SteamCMD
FROM wine-setup AS final
RUN add-apt-repository multiverse && \
    apt-get update && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y --no-install-recommends \
        gdebi-core \
        jq \
        gosu \
        xvfb \
        xserver-xorg \
        winbind \
        winetricks \
        libgl1-mesa-dri:i386 \
        libgl1:i386 \
        steam \
        steamcmd && \
    # Setup symlinks
    [ -e /usr/bin/steamcmd ] || ln -s /usr/games/steamcmd /usr/bin/steamcmd && \
    [ -e /usr/bin/wine ] || ln -s /opt/wine-stable/bin/wine /usr/bin/wine && \
    # In Wine 11.0, 'wine' is the 64-bit binary. Link it to wine64 for script compatibility.
    [ -e /usr/bin/wine64 ] || ln -s /opt/wine-stable/bin/wine /usr/bin/wine64 && \
    [ -e /usr/bin/wineserver ] || ln -s /opt/wine-stable/bin/wineserver /usr/bin/wineserver && \
    # Create steam user
    useradd -m -s /bin/bash steam && \
    # Clean up
    apt-get purge -y --auto-remove software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Setup the start script
COPY --chmod=755 start.sh /start.sh
RUN sed -i 's/\r$//' /start.sh

ENTRYPOINT ["/start.sh"]
