# Changelog

All notable changes to this project will be documented in this file.

## [2026-02-27]

- Added automated GitHub Actions workflows to check for Wine and V Rising updates and create Pull Requests.
- Updated Dockerfile to use explicit `ARG` version tracking for Wine and V Rising to support automated updates.
- Optimized Ubuntu 24.04 and Wine environment for improved server stability.
- Standardized LF line endings for all container-internal scripts to prevent execution errors.
- Automated Steam license acceptance during Docker build process.
- Fixed SteamCMD configuration to ensure reliable server installation and updates.
- Improved CI/CD pipeline with automated E2E testing
- Standardized project structure and documentation.

## [image 2026-02-21]

Docker image rebuild + tested on a linux dockerhost (unraid).<br>
For now, u need to add this to the compose file:<br>
`entrypoint: ["/bin/bash", "-c", "sed -i 's/\\r//g' /start.sh && exec /bin/bash /start.sh"]` <br>
Thx [laerdev](https://github.com/laerdev) for the fix.<br>

## [image 2025-08-01]

- Just tested the latest image for V-Rising 1.1. 
- Log will be spammed with these messages. Feel free to give me a solution here.<br>
  01b4:fixme:winsock:server_ioctl_sock Unsupported ioctl 4004747b (device=4004 access=1 func=d1e method=3)<br>
  vrising-1  | 01b4:fixme:winsock:WSAIoctl unsupported WS_IOCTL cmd (SIO_IDEAL_SEND_BACKLOG_QUERY)
- There is no way to continue a game from 1.0. I just checked with the discord community.
- Still an issue: when the server is passworded, joining via Steam seems not possible. Use the ingame server list to join.

## [image 2024-05-16] ([dmirtillo/vrising-dedicated:2.1](https://hub.docker.com/layers/dmirtillo/vrising-dedicated/2.1/images/sha256-00639c82158711d868f41750aa43f605bd35f5b775725137ef3b0b10ba80b52e?context=repo) or [latest](https://hub.docker.com/layers/dmirtillo/vrising-dedicated/latest/images/sha256-00639c82158711d868f41750aa43f605bd35f5b775725137ef3b0b10ba80b52e?context=repo)) 

- Merged with [pull65](https://github.com/dmirtillo/docker-vrising/pull/65) from [Killerherts](https://github.com/killerherts).<br>
  Logs older than 30 days are cleaned up on server start.
- Merged with [pull52](https://github.com/dmirtillo/docker-vrising/pull/52) from [Diyagi](https://github.com/diyagi).<br>
  Previous container version can still be grabbed via [dmirtillo/vrising-dedicated:2.0](https://hub.docker.com/layers/dmirtillo/vrising-dedicated/2.0/images/sha256-b9142d6f653685c92e25745f48cd205a1ffc7ed4aedef19011b03ab2a03a33c6?context=repo)<br>
  Main fixes are: clean shutdown & complete log to container log. Kudos!
- Added date to the logfile name, so per server launch, a logfile will be created. For now, they will not be automatically cleaned up.
- If you're experiencing [this issue](https://github.com/dmirtillo/docker-vrising/issues/51) with "[476:488:20240511,134828.926:ERROR http_transport_win.cc:388] HTTP status 403" in the log, pull [dmirtillo/vrising-dedicated:display](https://hub.docker.com/layers/dmirtillo/vrising-dedicated/display/images/sha256-592b9ace78b7228c08134804fa94b0f47766bb9202d86048a0a4ded81f765cda?context=repo) which uses xvfb.
- If you're experiencing [this issue](https://github.com/dmirtillo/docker-vrising/issues/43) with "wine: Assertion failed at address 00007F79E2C9EA7C (thread 0094)" in the log, u might need the latest wine from winehq, therefore grab [dmirtillo/vrising-dedicated:winehq](https://hub.docker.com/layers/dmirtillo/vrising-dedicated/winehq/images/sha256-f7f662258b30d6250d16718aa008a95b868336c92fdd98e56fd39bbca5626f8c?context=repo)
