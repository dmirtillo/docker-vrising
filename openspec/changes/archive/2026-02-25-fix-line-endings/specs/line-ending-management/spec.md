## ADDED Requirements

### Requirement: Line Ending Enforcement
The system SHALL ensure that shell scripts within the Docker image use LF line endings, regardless of the host environment or Git configuration.

#### Scenario: Script execution in container
- **WHEN** the container starts using `/start.sh`
- **THEN** the script shall execute successfully without "No such file or directory" or "command not found" errors related to `\r`.

### Requirement: Git Normalization
The repository SHALL be configured to automatically convert CRLF line endings to LF for `*.sh` files upon checkout or commit.

#### Scenario: Shell script checkout
- **WHEN** a `.sh` file is checked out on a Windows host
- **THEN** it shall have LF line endings if `.gitattributes` is correctly configured.
