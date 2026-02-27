# CI Publishing

## Purpose
TBD: Ensure stable automation for producing multi-stage CI pipelines and pushing tagged releases to Docker Hub.

## Requirements

### Requirement: Multi-Stage CI Pipeline
The GitHub Actions workflow SHALL be separated into consecutive `build`, `test`, and `publish` jobs.
- The `test` job must `needs: build`.
- The `publish` job must `needs: test`.

#### Scenario: Workflow execution
- **WHEN** the CI pipeline runs
- **THEN** the `build` job executes first, followed by `test`, and optionally `publish` if conditions are met.

### Requirement: Docker Hub Publishing
The pipeline SHALL automatically push successful images to Docker Hub (`dmirtillo/vrising-dedicated`).
- The `publish` job must only execute when a Git tag is pushed (e.g., `v1.0.0`).
- Must authenticate using `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
- Must tag and push both `latest` and the specific release tag version.

#### Scenario: Pushing a tagged release
- **WHEN** a semantic version tag (e.g., `v1.0.0`) is pushed and tests pass
- **THEN** the image is pushed to Docker Hub with `latest` and `v1.0.0` tags

#### Scenario: Pull request or regular commit execution
- **WHEN** the pipeline runs on a pull request or a standard commit to the `main` branch
- **THEN** the `publish` job is skipped and no images are pushed to Docker Hub

### Requirement: Automated Registry Pruning
The system SHALL have an automated scheduled workflow to prune temporary staging images from GitHub Container Registry (GHCR) and Docker Hub.
- Must run on a schedule (e.g., weekly).
- Must delete images that are untagged or represent old commit-SHA staging tags.
- Must preserve images tagged with official semantic release versions.
- Must document that Docker Hub pruning requires a Personal Access Token with Read, Write, and Delete permissions.

#### Scenario: Scheduled pruning of GHCR
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it authenticates with GHCR using a token with `delete:packages` scope and removes untagged images

#### Scenario: Scheduled pruning of Docker Hub
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it identifies and removes old, untagged, or staging images from Docker Hub, leaving official releases intact

### Requirement: Automated Dependency Updates
The system SHALL use Dependabot to automatically check for and propose updates to project dependencies.
- Must cover the GitHub Actions (`github-actions`) ecosystem.
- Must cover the Docker image (`docker`) ecosystem.
- Must run checks on a `weekly` schedule.

#### Scenario: Dependabot checks for updates
- **WHEN** the weekly schedule is triggered
- **THEN** Dependabot scans `.github/workflows/` and `Dockerfile` for outdated dependencies and creates Pull Requests for any updates found

### Requirement: Automated Update Workflows

The CI pipeline SHALL include automated workflows that check for updates to critical external dependencies and propose updates via Pull Requests.

#### Scenario: Scheduled Check for Wine Updates
- **WHEN** the scheduled monthly trigger executes (e.g., 1st of every month)
- **THEN** the workflow queries the WineHQ repository for the latest `winehq-stable` version for Ubuntu Noble
- **THEN** it compares the latest version with the `WINE_VERSION` specified in the `Dockerfile`
- **THEN** if a newer version is found, it creates a Pull Request updating the `Dockerfile`

#### Scenario: Scheduled Check for V Rising Updates
- **WHEN** the scheduled weekly trigger executes (e.g., every Sunday)
- **THEN** the workflow queries the SteamCMD Web API for the latest `buildid` of the V Rising Dedicated Server (AppID 1828900) on the `public` branch
- **THEN** it compares the latest `buildid` with the `VRISING_BUILD_ID` specified in the `Dockerfile`
- **THEN** if a newer build is found, it creates a Pull Request updating the `Dockerfile`
