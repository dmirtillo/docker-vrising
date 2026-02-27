## Why

The current CI pipeline pushes an image to both GitHub Container Registry (GHCR) and Docker Hub for every commit to the main branch. This clutters the registries with commit-SHA tagged images, making it difficult for users to identify stable releases and consuming unnecessary storage. We need a pipeline that uses GHCR for fast, temporary staging during tests, but only publishes official, semantic-versioned tags to the public registries. Additionally, we need an automated way to clean up the temporary staging images.

## What Changes

- **Update CI Triggers**: Modify `.github/workflows/docker-image.yml` to trigger the publish step only when a Git tag (e.g., `v1.0.0`) is pushed, rather than on every commit to `main`.
- **Ephemeral Staging**: The `build` job will continue to push commit-SHA tags to GHCR for the `test` job to consume, keeping the pipeline fast without passing large tarballs between jobs.
- **Automated Pruning**: Create a new workflow (e.g., `.github/workflows/prune-registries.yml`) with jobs dedicated to automatically deleting untagged or old commit-SHA images from both GHCR and Docker Hub.
- **Maintainer Documentation**: Create `docs/development.md` to document the CI/CD pipeline, release process, maintenance tasks (like pruning), and the **OpenSpec artifact-driven workflow** used for development.

## Capabilities

### New Capabilities
- `development-workflow`: Define and document the OpenSpec artifact-driven workflow used for managing changes in this repository.

### Modified Capabilities
- `ci-publishing`: The CI pipeline requirements are changing to enforce that public registry publication only occurs on tagged releases, and temporary staging images must be pruned periodically.

## Impact

- `.github/workflows/docker-image.yml`
- `.github/workflows/prune-registries.yml` (New file)
