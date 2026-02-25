## Why

Without end-to-end tests, changes to the Dockerfile or startup script can silently break the server initialization (e.g., Wine hanging on headless prompts, or SteamCMD failing to download the app). We need automated tests to verify the server successfully starts and initializes the game world before merging changes, ensuring high confidence in the image's stability.

## What Changes

- Create an automated test script (`scripts/test-startup.sh`) that builds the image, runs the container, and verifies the logs for successful server startup.
- Update the existing GitHub Actions workflow to run these E2E tests on pull requests and pushes to `main`.
- The test will specifically look for the "Startup Completed" log message to determine success, and it will include a timeout mechanism and clean teardown.

## Capabilities

### New Capabilities
<!-- None -->

### Modified Capabilities
- `automated-testing`: Update the requirement to define the exact success string to look for ("Startup Completed") and finalize the E2E test script requirements.

## Impact

- **CI/CD**: GitHub Actions workflow will take slightly longer to run but will guarantee the Docker image functions correctly.
- **Development**: Developers will have a reliable script to run locally to verify their changes before committing.
