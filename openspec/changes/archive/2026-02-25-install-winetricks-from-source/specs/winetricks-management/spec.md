## ADDED Requirements

### Requirement: Latest Winetricks Version
The system SHALL install the latest version of `winetricks` directly from the official GitHub repository source to ensure compatibility with modern Wine applications.

#### Scenario: Verify winetricks is installed from source
- **WHEN** the container image is built
- **THEN** the `/usr/bin/winetricks` file should exist and its content should match the script from GitHub (not the apt-managed version)

### Requirement: Winetricks Update Script
The system SHALL provide a utility script `/usr/bin/update_winetricks` that automates the process of fetching the latest `winetricks` and its bash-completion from the official source.

#### Scenario: Manual update functionality
- **WHEN** `/usr/bin/update_winetricks` is executed as root
- **THEN** it should download the latest `winetricks` and `winetricks.bash-completion` and move them to their respective system locations (`/usr/bin/` and `/usr/share/bash-completion/completions/`)

### Requirement: Bash Completion for Winetricks
The system SHALL include bash completion for `winetricks` to improve the command-line experience for users.

#### Scenario: Verify bash completion file
- **WHEN** checking for the completion file
- **THEN** `/usr/share/bash-completion/completions/winetricks` should exist and contain the completion script from the official repository
