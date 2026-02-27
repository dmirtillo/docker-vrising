## Why

Currently, when a new tag is pushed to the repository, the CI pipeline automatically builds and publishes the Docker image, but it does not create an official GitHub Release. Creating an automated GitHub Release that includes the corresponding section from the `CHANGELOG.md` will improve visibility for users tracking changes and provide a cleaner distribution point.

## What Changes

- Update the `.github/workflows/docker-image.yml` workflow to include a step that creates a GitHub Release when a tag is pushed.
- Implement a script or use an action to extract the release notes from `CHANGELOG.md` corresponding to the pushed tag (or latest date) and attach it to the GitHub Release.

## Capabilities

### New Capabilities
- None

### Modified Capabilities
- `ci-publishing`: Update the publishing requirements to include the automated creation of a GitHub Release with changelog notes.

## Impact

- `.github/workflows/docker-image.yml`
