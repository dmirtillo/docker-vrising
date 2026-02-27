# Capability: server-installation

## Purpose
Manage the installation and deployment of the V Rising Dedicated Server, ensuring correct configuration and reliability across platforms.

## Requirements

### Requirement: Windows Platform Override
The system SHALL force SteamCMD to use the Windows platform configuration when installing the V Rising Dedicated Server, regardless of the host OS.

#### Scenario: Install on Linux
- **WHEN** the container starts on a Linux host
- **THEN** `steamcmd` is executed with `+@sSteamCmdForcePlatformType windows`
- **AND** the V Rising server files (Windows binaries) are downloaded successfully

### Requirement: Robust SteamCMD Update
The system SHALL handle SteamCMD self-updates without interrupting the installation process or losing configuration flags.

#### Scenario: SteamCMD Self-Update
- **WHEN** `steamcmd` requires an update
- **THEN** the update is performed in a separate execution phase
- **AND** the subsequent installation phase proceeds with the correct platform configuration
