# Proposal: Fix SteamCMD "Missing Configuration" Error

## Why
The `steamcmd` process fails to install the Windows-only V Rising Dedicated Server on Linux because the platform override (`+@sSteamCmdForcePlatformType windows`) is lost during self-update restarts. This blocks automated testing and server deployment.

## What Changes
- Modify `start.sh` to execute `steamcmd` in two separate phases:
    1.  **Update Phase**: A simple login/quit cycle to allow `steamcmd` to update itself and restart.
    2.  **Install Phase**: The actual installation command with platform override, which will now persist as no further updates/restarts occur.

## Capabilities

### New Capabilities
- `server-installation`: Defines the requirements for robustly installing the V Rising server using SteamCMD, including platform overrides and update handling.

### Modified Capabilities
- (None)

## Impact
- `start.sh`: The script will be refactored to split the `steamcmd` command.
