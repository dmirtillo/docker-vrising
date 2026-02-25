# Troubleshooting

Common issues and solutions for running the V Rising dedicated server in Docker.

## Common Log Messages (Harmless)

Since version 1.1, the logs may frequently display messages like these. You can safely ignore them:

```text
01b4:fixme:winsock:server_ioctl_sock Unsupported ioctl 4004747b (device=4004 access=1 func=d1e method=3)
01b4:fixme:winsock:WSAIoctl unsupported WS_IOCTL cmd (SIO_IDEAL_SEND_BACKLOG_QUERY)
```

## Windows Docker Host Issues

If you are running Docker on a Windows host and encounter the following exception:

```text
vrising-1 | 0024:err:module:LdrInitializeThunk "UnityPlayer.dll" failed to initialize, aborting
vrising-1 | 0024:err:module:LdrInitializeThunk Initializing dlls for L"Z:\\mnt\\vrising\\server\\VRisingServer.exe" failed, status c0000005
```

**Solution**: You must use absolute paths for your volume mappings. Example:

```yaml
volumes:
  - E:\\my-server-folder\\server:/mnt/vrising/server
```

## Performance & Startup

- **Long Startup Times**: Depending on your hardware and network, the server can take up to **10 minutes** to fully initialize, especially when downloading updates or loading large save files.
- **CPU Requirements**: The server requires a modern CPU. If your CPU does not support AVX/AVX2, some plugins like `lib_burst_generated.dll` might cause crashes. The container includes a fix to disable these plugins if AVX is missing.

## Getting Help

- [V Rising Official Instructions](https://github.com/StunlockStudios/vrising-dedicated-server-instructions)
- [Project GitHub Issues](https://github.com/TrueOsiris/docker-vrising/issues)
