## Why

Currently, the Docker image relies on the latest available packages for Wine and V Rising at build time. This manual tracking process is error-prone and can lead to outdated or incompatible server instances. We need automated systems to check for upstream updates and automatically open PRs to keep the image fresh without manual intervention.

## What Changes

- Add a new GitHub Actions workflow to check for Wine updates monthly.
- Add a new GitHub Actions workflow to check for V Rising dedicated server updates weekly via the SteamCMD API.
- Update `Dockerfile` to track explicitly defined versions using `ARG` for Wine and V Rising to enable version comparison.
- The workflows will use `peter-evans/create-pull-request` to open PRs when new versions are detected, triggering a fresh Docker build upon merge.

## Capabilities

### New Capabilities
- `dependency-automation`: Defines the requirements and behavior for automated checks and updates of critical external dependencies (Wine, V Rising).

### Modified Capabilities
- `ci-publishing`: Update the CI/CD requirements to integrate the new automated PR generation workflows.

## Impact

- `Dockerfile`: Will be modified to use explicit `ARG` tracking for Wine and V Rising versions.
- `.github/workflows/`: New automated update checking workflows will be introduced.
- Existing CI/CD processes will benefit from automated dependency tracking, reducing manual maintenance overhead.
