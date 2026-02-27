## MODIFIED Requirements

### Requirement: Automated Registry Pruning
The system SHALL have an automated scheduled workflow to prune temporary staging images from GitHub Container Registry (GHCR) and Docker Hub.
- Must run on a schedule (e.g., weekly).
- Must delete images that are untagged or represent old commit-SHA staging tags.
- Must preserve images tagged with official semantic release versions.
- Must document that Docker Hub pruning requires a Personal Access Token with Read, Write, and Delete permissions.
- Must use the correct package identifier for GHCR (e.g., `docker-vrising`) to successfully locate packages for pruning.

#### Scenario: Scheduled pruning of GHCR
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it authenticates with GHCR using a token with `delete:packages` scope
- **THEN** it uses the `docker-vrising` package name to locate the package
- **THEN** it removes untagged images from that package

#### Scenario: Scheduled pruning of Docker Hub
- **WHEN** the prune workflow is triggered via schedule
- **THEN** it identifies and removes old, untagged, or staging images from Docker Hub, leaving official releases intact
