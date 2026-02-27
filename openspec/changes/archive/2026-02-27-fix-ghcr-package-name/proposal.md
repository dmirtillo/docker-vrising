## Why

The automated registry pruning workflow (`.github/workflows/prune-registries.yml`) is currently failing because it's looking for a GHCR package named `vrising-dedicated`, but the actual package name on GHCR defaults to the repository name, `docker-vrising`.

## What Changes

- Update the `container` parameter in the `prune-ghcr` job within `.github/workflows/prune-registries.yml` from `vrising-dedicated` to `docker-vrising`.

## Capabilities

### New Capabilities
- None

### Modified Capabilities
- `ci-publishing`: Updating the configuration for GHCR package pruning to use the correct package identifier.

## Impact

- `.github/workflows/prune-registries.yml`
