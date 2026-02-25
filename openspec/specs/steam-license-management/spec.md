# Capability: steam-license-management

## Purpose
Manage the automated acceptance of the Steam License Agreement for headless installations.

## Requirements

### Requirement: Automatic Steam License Acceptance
The Docker build process SHALL automatically accept the Steam License Agreement during the installation of the `steamcmd` package.

#### Scenario: Headless installation of steamcmd
- **WHEN** the `apt-get install` command for `steamcmd` is executed
- **THEN** the Steam License Agreement is already accepted via `debconf-set-selections`
- **AND** the installation proceeds without user interaction or failure
