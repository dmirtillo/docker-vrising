## MODIFIED Requirements

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
