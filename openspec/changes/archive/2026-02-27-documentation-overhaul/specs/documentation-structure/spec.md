## ADDED Requirements

### Requirement: Scenario-based Installation Recipes
The documentation SHALL provide distinct Docker Compose configuration examples tailored to common playstyles (e.g., Solo/Co-op, Standard PvE, Standard PvP).

#### Scenario: User searches for PvP setup
- **WHEN** a user reads the installation guide looking for PvP
- **THEN** they find a dedicated Docker Compose recipe with appropriate port and listing settings

### Requirement: Admin and Ban Configuration Guide
The documentation SHALL explicitly detail the process of assigning server administrators using `adminlist.txt` and managing banned players using `banlist.txt`.

#### Scenario: User wants to become admin
- **WHEN** the user needs to use in-game commands
- **THEN** the documentation shows how to place `adminlist.txt` in the persistent data volume and authenticate

#### Scenario: Admin wants to ban a player
- **WHEN** an administrator needs to ban a malicious player
- **THEN** the documentation shows how to configure `banlist.txt` in the persistent data volume

### Requirement: RCON Configuration and Commands Guide
The documentation SHALL instruct users on how to enable and configure RCON using the native environment variable prefix `HOST_SETTINGS_Rcon__` and SHALL provide a list of useful RCON commands for server management.

#### Scenario: User configures RCON
- **WHEN** a user wants to enable remote console
- **THEN** they are provided with Docker Compose environment variables to set the port and password

#### Scenario: User executes RCON commands
- **WHEN** a user has RCON enabled
- **THEN** they can reference a list of common RCON commands directly in the documentation

### Requirement: Data Persistence Visualization
The documentation SHALL include visual diagrams explaining the relationship between host directories and container data volumes.

#### Scenario: User maps volumes
- **WHEN** a user is confused about where save files are stored
- **THEN** an ASCII diagram clarifies the difference between the Steam installation folder and the persistent data folder

### Requirement: Save Rollback Procedure
The troubleshooting documentation SHALL provide step-by-step instructions on recovering corrupted worlds using the `AutoSaveSmartKeep` folder structure.

#### Scenario: Server crashes and corrupts save
- **WHEN** a user's world fails to load
- **THEN** the documentation explains how to replace `AutoSave_Latest` with an older timestamped folder

### Requirement: Modding Information and Disclaimer
The documentation SHALL provide information on how modding is typically achieved on the server, while clearly stating the provided Docker image runs vanilla V Rising and requires manual intervention for BepInEx.

#### Scenario: User asks about mods
- **WHEN** a user tries to install server mods
- **THEN** the documentation explains the general mechanism (placing files in the mounted server folder) and sets expectations
