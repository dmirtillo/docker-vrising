## MODIFIED Requirements

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

## ADDED Requirements

### Requirement: Automated Registry Pruning
The system SHALL have an automated scheduled workflow to prune temporary staging images from GitHub Container Registry (GHCR) and Docker Hub.
- Must run on a schedule (e.g., weekly).
- Must delete images that are untagged or represent old commit-SHA staging tags.
- Must preserve images tagged with official semantic release versions.

#### Scenario: Scheduled pruning of GHCR
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it authenticates with GHCR using a token with `delete:packages` scope and removes untagged images

#### Scenario: Scheduled pruning of Docker Hub
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it identifies and removes old, untagged, or staging images from Docker Hub, leaving official releases intact