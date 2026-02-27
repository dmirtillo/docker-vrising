## ADDED Requirements

### Requirement: Pre-configured Playstyle Templates
The server installation documentation SHALL offer multiple pre-configured Docker Compose examples based on the desired playstyle, rather than a single generic example.

#### Scenario: Deploying a PvE Server
- **WHEN** the user copies the PvE template
- **THEN** the server starts with `GAME_SETTINGS_GameModeType=PvE` and appropriate standard ports configured
