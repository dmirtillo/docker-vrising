## Context

The registry pruning workflow is failing due to an incorrect package name for GHCR. GitHub Actions defaults the GHCR package name to the repository name (`docker-vrising`), while the workflow was configured to look for `vrising-dedicated` (which is used for Docker Hub).

## Goals / Non-Goals

**Goals:**
- Fix the GHCR pruning job by using the correct package name.
- Ensure the pruning workflow can successfully identify and remove untagged images from GHCR.

**Non-Goals:**
- Changing the Docker Hub repository name.
- Modifying the build or publish logic.

## Decisions

- **Use `docker-vrising` for GHCR package identification**: This matches the actual package name created by the repository's build pipeline.

## Risks / Trade-offs

- [Risk] → If the repository is renamed in the future, the pruning workflow will break again.
- [Mitigation] → We could use `${{ github.event.repository.name }}` but hardcoding it to the current known-good value is safer and more explicit for now, matching how it was previously set.
