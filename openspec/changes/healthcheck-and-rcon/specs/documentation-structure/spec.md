## MODIFIED Requirements

### Requirement: RCON Configuration and Commands Guide
The documentation SHALL instruct users on how to enable and configure RCON using the native environment variable prefix `HOST_SETTINGS_Rcon__` and SHALL provide a list of useful RCON commands for server management. It MUST also provide a `docker-compose.yml` example demonstrating how to run a persistent RCON sidecar container that depends on the V Rising server's health status.

#### Scenario: User configures RCON
- **WHEN** a user wants to enable remote console
- **THEN** they are provided with Docker Compose environment variables to set the port and password

#### Scenario: User configures an RCON sidecar
- **WHEN** a user wants to run RCON continuously alongside the server
- **THEN** they are provided with a `docker-compose.yml` snippet showing a `gorcon/rcon-cli` container using `depends_on: service_healthy` to wait for the server

#### Scenario: User executes RCON commands
- **WHEN** a user has RCON enabled
- **THEN** they can reference a list of common RCON commands directly in the documentation
