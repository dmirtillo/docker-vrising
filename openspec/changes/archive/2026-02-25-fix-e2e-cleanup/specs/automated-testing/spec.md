## MODIFIED Requirements

### Requirement: Local Test Script
The project SHALL include a local test script (`scripts/test-startup.sh`) to verify server initialization.
- Must start a container using isolated/temporary volumes.
- Must wait for the server to download via SteamCMD and initialize via Wine.
- Must determine success by finding the exact string "Startup Completed" in the container logs.
- Must include a timeout mechanism (e.g., 10 minutes) to prevent hanging tests.
- Must cleanly tear down the container and volumes upon success or failure. Cleanup must account for root-owned or steam-owned files within mounted volumes by using a privileged cleanup container.
- Must exit with code `0` for success and `>0` for failure.
- Must accept an optional image name argument to skip building the image from source. If no argument is provided, it must build the image locally.

#### Scenario: Successful Server Startup
- **WHEN** the test script is executed
- **THEN** the container starts and the logs contain "Startup Completed"
- **THEN** the script exits with code 0

#### Scenario: Server Startup Timeout
- **WHEN** the server fails to initialize within the timeout period
- **THEN** the script tears down the container
- **THEN** the script exits with code >0

#### Scenario: CI execution
- **WHEN** an image name is passed as the first argument
- **THEN** the script skips building the image and uses the provided image name

#### Scenario: Directory Cleanup
- **WHEN** the script exits (success or failure)
- **THEN** a temporary container is spawned to delete the contents of the test directory
- **THEN** the test directory on the host is successfully removed without permission errors
