# Automated End-to-End Testing

## Overview
The V Rising server image relies on a complex stack: Ubuntu 24.04, Wine, Xvfb, and SteamCMD. Simple `docker build` checks are insufficient to guarantee the image works. We need automated tests to verify the server actually starts and initializes correctly.

## Requirements

### Requirement: Local Test Script
The project SHALL include a local test script (`scripts/test-startup.sh`) to verify server initialization.
- Must start a container using isolated/temporary volumes.
- Must wait for the server to download via SteamCMD and initialize via Wine.
- Must determine success by finding the exact string "Startup Completed" in the container logs.
- Must include a timeout mechanism (e.g., 10 minutes) to prevent hanging tests.
- Must cleanly tear down the container and volumes upon success or failure.
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

### Requirement: Continuous Integration
The project SHALL run the automated test script in GitHub Actions.
- The existing `.github/workflows/docker-image.yml` must be updated.
- Must execute the test script on every PR and Push to `main`.
- Should upload the container logs as a build artifact if the test fails for debugging purposes.

#### Scenario: CI Pipeline execution
- **WHEN** code is pushed to main or a PR is opened
- **THEN** the GitHub Actions workflow executes `scripts/test-startup.sh`
- **THEN** the pipeline fails if the script exits with code >0
