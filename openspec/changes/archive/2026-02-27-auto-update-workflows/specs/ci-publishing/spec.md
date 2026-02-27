## ADDED Requirements

### Requirement: Automated Update Workflows

The CI pipeline SHALL include automated workflows that check for updates to critical external dependencies and propose updates via Pull Requests.

#### Scenario: Scheduled Check for Wine Updates
- **WHEN** the scheduled monthly trigger executes (e.g., 1st of every month)
- **THEN** the workflow queries the WineHQ repository for the latest `winehq-stable` version for Ubuntu Noble
- **THEN** it compares the latest version with the `WINE_VERSION` specified in the `Dockerfile`
- **THEN** if a newer version is found, it creates a Pull Request updating the `Dockerfile`

#### Scenario: Scheduled Check for V Rising Updates
- **WHEN** the scheduled weekly trigger executes (e.g., every Sunday)
- **THEN** the workflow queries the SteamCMD Web API for the latest `buildid` of the V Rising Dedicated Server (AppID 1828900) on the `public` branch
- **THEN** it compares the latest `buildid` with the `VRISING_BUILD_ID` specified in the `Dockerfile`
- **THEN** if a newer build is found, it creates a Pull Request updating the `Dockerfile`
