## Why

The automated registry pruning workflow (`.github/workflows/prune-registries.yml`) currently fails for two reasons. First, the GHCR pruning action `vlaurin/action-ghcr-prune` uses a deprecated `untagged: true` syntax instead of `prune-untagged: true`, causing the job to fail with a missing token error. Second, the Docker Hub cleanup script receives a `403 Forbidden` error when attempting to delete tags, indicating an issue with the access token scope or permissions. We need to fix the GHCR syntax and update the documentation to instruct users on correctly configuring their Docker Hub tokens. Additionally, we want to set up Dependabot to keep GitHub Actions and Docker image dependencies automatically updated.

## What Changes

- Update `.github/workflows/prune-registries.yml` to use `prune-untagged: true` for the GHCR pruning step.
- Update `docs/development.md` to explicitly document the required token scopes for the Docker Hub personal access token (`DOCKERHUB_TOKEN`) to allow for tag deletion.
- Configure Dependabot (`.github/dependabot.yml`) to automatically check for updates to GitHub Actions and Docker dependencies on a weekly basis.

## Capabilities

### New Capabilities

### Modified Capabilities
- `ci-publishing`: Modifying the requirements around registry pruning to specify the required Docker Hub token permissions, and adding requirements for automated dependency updates via Dependabot.

## Impact

- `.github/workflows/prune-registries.yml`
- `docs/development.md`
- `.github/dependabot.yml` (New file)
