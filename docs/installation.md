# Installation

This guide covers how to set up and run the V Rising dedicated server using Docker.

## Quick Start (Docker Compose)

The recommended way to run the server is using [Docker Compose](https://docs.docker.com/compose/).

```yaml
services:
  vrising:
    image: trueosiris/vrising
    # Fix for line endings in start script
    entrypoint: ["/bin/bash", "-c", "sed -i 's/\\r//g' /start.sh && exec /bin/bash /start.sh"]
    environment:
      - TZ=Europe/Paris
      - SERVERNAME=vrising-dedicated
    volumes:
      - ./server:/mnt/vrising/server
      - ./persistentdata:/mnt/vrising/persistentdata
    ports:
      - '9876:9876/udp'
      - '9877:9877/udp'
    restart: unless-stopped
```

### Starting the server
```bash
docker-compose up -d
```

## Docker CLI

If you prefer using the Docker CLI directly:

```bash
docker run -d --name='vrising' \
  --restart=unless-stopped \
  -e TZ="Europe/Paris" \
  -e SERVERNAME="vrising-dedicated" \
  -v "$(pwd)/server:/mnt/vrising/server" \
  -v "$(pwd)/persistentdata:/mnt/vrising/persistentdata" \
  -p 9876:9876/udp \
  -p 9877:9877/udp \
  --entrypoint "/bin/bash" \
  trueosiris/vrising \
  -c "sed -i 's/\r//g' /start.sh && exec /bin/bash /start.sh"
```

## Post-Installation

- Launching the server can take up to 10 minutes, especially on the first run or with an existing save.
- Once the server is running, you can find your configuration files in your host's `persistentdata/Settings` folder.
- For networking and port forwarding details, see [Networking & Ports](networking.md).
