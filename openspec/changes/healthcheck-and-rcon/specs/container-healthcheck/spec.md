## ADDED Requirements

### Requirement: UDP Query Port Healthcheck
The container SHALL provide a mechanism to verify its readiness by checking if the V Rising Server Query Port (UDP) is open and accepting connections.
- The image MUST include a tool capable of performing a UDP ping (e.g., `netcat-openbsd`).
- The healthcheck MUST account for the significant startup delay of the Wine/V Rising server by using a sufficient start period.
- The healthcheck MUST target the configured `QUERYPORT` (default 9877) on the localhost interface (`127.0.0.1`).

#### Scenario: Server is still starting
- **WHEN** the Docker engine runs the healthcheck during the initial startup phase
- **THEN** the UDP ping fails, but the container remains in a `starting` state due to the configured `start_period`

#### Scenario: Server is fully loaded and ready
- **WHEN** the V Rising server finishes loading the world and opens its query port
- **THEN** the UDP ping succeeds and the container is marked as `healthy`
