## Why

Currently, our CI pipeline builds the Docker image and immediately runs the E2E tests within the same job, without pushing the validated image to a public registry. We need to split the build, test, and publish phases into consecutive jobs to isolate failures, speed up retries using Docker Buildx caching, and automatically publish the tested image to Docker Hub (`dmirtillo/vrising-dedicated`) upon a successful merge to `main`.

## What Changes

- Split the GitHub Actions workflow into three consecutive jobs: `build`, `test`, and `publish`.
- Implement Docker Buildx and GitHub Container Registry (GHCR) to pass the built image securely between jobs.
- Modify the local test script (`scripts/test-startup.sh`) to optionally accept an image name argument, skipping the local build step when running in CI.
- Configure secure Docker Hub publishing using GitHub Actions Secrets (`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`).
- Ensure images are only published to Docker Hub on the `main` branch after tests pass.

## Capabilities

### New Capabilities
- `ci-publishing`: Define requirements for consecutive CI jobs and automated Docker Hub publishing.

### Modified Capabilities
- `automated-testing`: Update the local test script requirement to accept a pre-built image argument.

## Impact

- **CI/CD**: The pipeline will become more robust, observable, and capable of automatically publishing production-ready images to Docker Hub.
- **Security**: Publishing credentials will be managed securely via GitHub Secrets.
- **Development**: The local test script will be slightly modified to support CI execution, but local developer workflows will remain unchanged.