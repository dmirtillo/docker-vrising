# Design: Fix SteamCMD "Missing Configuration" Error

## Context
The current implementation of `start.sh` executes `steamcmd` in a single command that attempts to override the platform to Windows, update the SteamCMD tool, and install the game server. However, `steamcmd` on Linux (installed via apt package wrapper) restarts itself during updates. This restart process causes the platform override argument to be lost or ineffective, leading `steamcmd` to attempt installing a Linux version of the game which does not exist, resulting in a "Missing configuration" error.

## Goals / Non-Goals
**Goals:**
- Ensure V Rising Dedicated Server (Windows-only) installs correctly on the Linux container.
- Persist the platform override configuration during the installation process.
- Allow `steamcmd` to update itself without breaking the installation flow.

**Non-Goals:**
- Changing the installation method of `steamcmd` (e.g., switching from apt to tarball) unless the script fix fails.
- Changing the base OS (Ubuntu 24.04).

## Decisions
- **Split SteamCMD Execution**: We will execute `steamcmd` in two distinct passes.
    - Pass 1: `steamcmd +login anonymous +quit`. This forces the self-update process to complete and restart as needed.
    - Pass 2: `steamcmd +@sSteamCmdForcePlatformType windows ...`. This executes the installation. Since `steamcmd` is already up-to-date from Pass 1, it will not restart, and the platform override argument will be respected.

## Risks / Trade-offs
- **Risk**: `steamcmd` might still update if a new version is released between Pass 1 and Pass 2 (extremely unlikely race condition).
    - **Mitigation**: Negligible risk.
- **Risk**: The `apt` wrapper might have other quirks.
    - **Mitigation**: If this fails, we will fallback to installing `steamcmd` from the official tarball in the Dockerfile.

## Migration Plan
- Apply changes to `start.sh`.
- Rebuild the image.
- Run tests.
