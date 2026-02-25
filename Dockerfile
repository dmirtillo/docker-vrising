FROM ubuntu:22.04 
LABEL maintainer="Tim Chaubet"

ARG DEBIAN_FRONTEND="noninteractive"

# 1. Install all dependencies, setup users, and clean up in one layer
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        software-properties-common \
        tzdata \
        gdebi-core \
        wget \
        jq \
        gosu \
        xvfb \
        xserver-xorg \
        winbind \
        winetricks \
        wine \
        ca-certificates && \
    add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libgl1-mesa-glx:i386 \
        steam \
        steamcmd && \
    ln -s /usr/games/steamcmd /usr/bin/steamcmd && \
    # Create steam user
    useradd -m -s /bin/bash steam && \
    # Setup SteamCMD agreement
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    # Clean up
    apt-get purge -y --auto-remove software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# 2. Setup the start script
COPY --chmod=755 start.sh /start.sh
RUN sed -i 's/\r$//' /start.sh

# 3. Final configuration
# We don't define volumes here to avoid issues with permissions at build time
# The entrypoint will handle ownership of the mounted volumes
ENTRYPOINT ["/start.sh"]
