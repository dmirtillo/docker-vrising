<p align="center">
  <a href="https://github.com/TrueOsiris/docker-vrising">
    <img alt="Iroh" src="https://github.com/TrueOsiris/docker-vrising/blob/main/assets/docker-virising.png?raw=true" height="250">
  </a>
  <p  align="center">Dockerized V Rising dedicated server in an Ubuntu 22.04 container with Wine.</p>
</p>

[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/trueosiris/vrising)
[![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white)](https://github.com/TrueOsiris/docker-vrising)
[![Wine](https://img.shields.io/badge/Wine-800000?logo=wine&logoColor=white)](https://www.winehq.org/)
[![Steam](https://img.shields.io/badge/Steam-1b2838?logo=steam&logoColor=white)](https://store.steampowered.com/app/1604030/V_Rising/)
[![V Rising](https://img.shields.io/badge/V%20Rising-1604030-8A0303?logo=steam&logoColor=white)](https://store.steampowered.com/app/1604030/V_Rising/)
[![Docker Pulls](https://img.shields.io/docker/pulls/trueosiris/vrising?logo=docker&label=pulls)](https://hub.docker.com/r/trueosiris/vrising)
[![Docker Stars](https://img.shields.io/docker/stars/trueosiris/vrising?logo=docker&label=stars)](https://hub.docker.com/r/trueosiris/vrising)
[![Docker Image Size](https://img.shields.io/docker/image-size/trueosiris/vrising/latest?logo=docker&label=image%20size)](https://hub.docker.com/r/trueosiris/vrising)
[![GitHub stars](https://img.shields.io/github/stars/TrueOsiris/docker-vrising?logo=github&label=stars)](https://github.com/TrueOsiris/docker-vrising)
[![GitHub forks](https://img.shields.io/github/forks/TrueOsiris/docker-vrising?logo=github&label=forks)](https://github.com/TrueOsiris/docker-vrising)
[![GitHub open issues](https://img.shields.io/github/issues/TrueOsiris/docker-vrising?logo=github&label=open%20issues)](https://github.com/TrueOsiris/docker-vrising/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/TrueOsiris/docker-vrising?logo=github&label=closed%20issues)](https://github.com/TrueOsiris/docker-vrising/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub last-commit](https://img.shields.io/github/last-commit/TrueOsiris/docker-vrising?logo=github&label=last%20commit)](https://github.com/TrueOsiris/docker-vrising/commits)


## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full history of changes.

## Environment variables


| Variable   | Key                    | Description                                                                       |
| ------------ | ------------------------ | ----------------------------------------------------------------------------------- |
| TZ         | Europe/Brussels        | timezone for ntpdate                                                              |
| SERVERNAME | published servername   | mandatory setting that overrules the ServerHostSettings.json entry                |
| WORLDNAME  | optional worldname     | default = world1. No real need to alter this. saves will be in a subdir WORLDNAME |
| GAMEPORT   | optional game udp port | to overrule Port in ServerHostSettings.json config                                |
| QUERYPORT  | optional query port    | to overrule QueryPort in ServerHostSettings.json config                           |
| LOGDAYS | optional lifetime of logfiles | overrule default of 30 days |
| BRANCH | optional server version | Allows to run the server version legacy-1.0.x-pc |

## Ports


| Exposed Container port | Type | Default |
| ---------------------- | ---- | ------- |
| 9876                   | UDP  | ✔️      |
| 9877                   | UDP  | ✔️      |

## Volumes


| Volume             | Container path              | Description                             |
| -------------------- | ----------------------------- | ----------------------------------------- |
| steam install path | /mnt/vrising/server         | path to hold the dedicated server files |
| world              | /mnt/vrising/persistentdata | path that holds the world files         |

## Docker cli

```bash
docker run -d --name='vrising' \
--net='bridge' \
--restart=unless-stopped \
-e WINEDEBUG=fixme-all \
-e TZ="Europe/Paris" \
-e SERVERNAME="trueosiris-V" \
-v '/path/on/host/server':'/mnt/vrising/server':'rw' \
-v '/path/on/host/persistentdata':'/mnt/vrising/persistentdata':'rw' \
-p 9876:9876/udp \
-p 9877:9877/udp \
--entrypoint "/bin/bash" \
trueosiris/vrising \
-c "sed -i 's/\r//g' /start.sh && exec /bin/bash /start.sh"
```

## docker-compose.yml

```yaml
services:
  vrising:
    image: trueosiris/vrising
    entrypoint: ["/bin/bash", "-c", "sed -i 's/\\r//g' /start.sh && exec /bin/bash /start.sh"]
    environment:
      - TZ=Europe/Paris
      - SERVERNAME=vrising-TrueOsiris2026
      - WINEDEBUG=fixme-all
    volumes:
      - type: bind
        source: ./server
        target: /mnt/vrising/server
        bind:
          create_host_path: true
      - type: bind
        source: ./persistentdata
        target: /mnt/vrising/persistentdata
        bind:
          create_host_path: true
    ports:
      - '9876:9876/udp'
      - '9877:9877/udp'
    restart: unless-stopped
    network_mode: bridge
```

## Newest modifications:

- **Intuitive parameters** — If you want to modify parameters in `ServerGameSettings.json` and `ServerHostSettings.json`, add environment variables starting with `GAME_SETTINGS_` and `HOST_SETTINGS_` (both must be uppercase) in your docker-compose.yml file. The parameter names that follow are case-insensitive, so `HOST_SETTINGS_LISTONSTEAM` and `HOST_SETTINGS_ListOnSteam` both work.
```yaml
environment:
  - HOST_SETTINGS_ListOnSteam=true
  - HOST_SETTINGS_LISTONEOS=true
  - GAME_SETTINGS_GAMEMODETYPE=PvE
```
- **Supports dynamic modification of nested JSON parameters** — since some parameter names contain `_`, a double underscore `__` is used to separate levels.
```yaml
environment:
  - HOST_SETTINGS_Rcon__Enabled=true
  - HOST_SETTINGS_Rcon__Password=powerfulpwd
  - GAME_SETTINGS_UnitStatModifiers_Global__MaxHealthModifier=2
  - GAME_SETTINGS_CastleStatModifiers_Global__HeartLimits__Level1__FloorLimit=100
```
- **Fail-safe** — entering a non-existent parameter like `HOST_SETTINGS_NotExistKey=1` will not be written to the configuration file.
- **Parameter type validation** — if the input type differs from the original like `HOST_SETTINGS_Port=abcd`, it will not be written to the configuration file.
- All modified parameter settings can be viewed in:
  - `/mnt/vrising/persistentdata/Settings/ServerGameSettings.json`
  - `/mnt/vrising/persistentdata/Settings/ServerHostSettings.json`

## Links

- [V Rising Dedicated Server Instructions](https://github.com/StunlockStudios/vrising-dedicated-server-instructions)
- [Dockerhub - Trueosiris/vrising](https://hub.docker.com/repository/docker/trueosiris/vrising)
- [Github - trueosiris/vrising](https://github.com/TrueOsiris/docker-vrising)

## RCON <small>- Optional</small>

To enable RCON edit `ServerHostSettings.json` and paste following lines after `QueryPort`. To communicate using RCON protocal use the [RCON CLI](https://github.com/gorcon/rcon-cli) by gorcon.

```json
"Rcon": {
  "Enabled": true,
  "Password": "docker",
  "Port": 25575
},
```

## Remarks

- Server config files are in `/path/on/host/persistentdata/Settings`. Files in `/path/on/host/server/` are overwritten on Steam update. <br>
  Priority of settings is

  a. container variables

  b. files in /persistentdata

  c. files in /server. (and these are reset to defaults each new patch)

  If there are no files in `/path/on/host/persistentdata/Settings` on container start, the default files will be copied there from the /server directory.<br>
  Edit `ServerHostSettings.json` if you want to change the ports, descriptions etc.
- Description can be changed in `/path/on/host/persistentdata/Settings/ServerHostSettings.json`. The server will have to be restarted after changes.
- If you use different internal & external ports, you can only use direct connect. For example `-p 12345:6789/udp` container port 6789 as defined in ServerHostSettings.json, and exposed as 12345 will make your server invisible.
- Make sure `"ListOnSteam": true,` and `"ListOnEOS": true` are set in the ServerHostSettings.json in \persistentdata, so the server is visible in the serverlist.
- When the server is passworded, joining via Steam seems <b>not</b> possible. Use the ingame server list to join.
- Launching the server can take up to 10 minutes, even on a fast system, certainly with an existing save.
- If you want to see the server in the server list and want to use 27015-27016/UDP, you'll need to change the ports in the ServerHostSettings.json file to 27015 and 27016. Then expose these ports (below). Of course, forward these udp ports on your firewall from incoming wan to the ports on the internal ip of your dockerhost.

  - Start the container & let the server install.
  - Stop the container.
  - Alter the ports in `/path/on/host/persistentdata/Settings/ServerHostSettings.json` to
    ```
     "Port": 27015,
     "QueryPort": 27016,
    ```
  - On your firewall, port forward incoming wan udp ports 27015 and 27016 to the same udp ports on your dockerhost ip.
  - Restart the container with these ports:
    ```
     -p 27015:27015/udp
     -p 27016:27016/udp
    ```
- If you want to continue from your local game, stop the container, overwrite the persistentdata
  contents with your local data, and relaunch the server.
  
- If you're running windows as a docker host, you'll get this exception:
  ```
  vrising-1  | 0024:err:module:LdrInitializeThunk "UnityPlayer.dll" failed to initialize, aborting
  vrising-1  | 0024:err:module:LdrInitializeThunk Initializing dlls for L"Z:\\mnt\\vrising\\server\\VRisingServer.exe" failed, status c0000005
  ```
  Unless you use volumes like this:
  ```
  volumes:
  - E:\something\server:/mnt/vrising/server
  ```
- You might want to add a separate custom settings file (Custom.json) in persistentdata.
  - start the server to have the files created
  - shut down the server
  - add custom.json to the persistentdata folder (see volumes)
  - Then point your ServerHostSettings in persistentdata/Settings to that file by adding `"GameSettingsPreset": "Custom"`
  - start the server again.

## Docker log

Since 1.1 the log will be spamming these messages, but no need to worry:<br>
vrising-1   | 01b4:fixme:winsock:server_ioctl_sock Unsupported ioctl 4004747b (device=4004 access=1 func=d1e method=3)<br>
vrising-1   | 01b4:fixme:winsock:WSAIoctl unsupported WS_IOCTL cmd (SIO_IDEAL_SEND_BACKLOG_QUERY)<br>

## Credits

- All credits go to the awesome designers of [V-Rising](https://playvrising.com/)!
