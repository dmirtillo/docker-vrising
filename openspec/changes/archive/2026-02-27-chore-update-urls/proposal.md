## Why

The project repository and Docker Hub image have been moved to a new namespace. This change ensures all documentation, README files, and CI configurations point to the correct URLs and removes references to the previous maintainer ('trueosiris').

## What Changes

- Update repository URL in README and documentation to `github.com/dmirtillo/docker-vrising`.
- Update Docker Hub image URL to `https://hub.docker.com/r/dmirtillo/vrising-dedicated`.
- Remove all occurrences of 'trueosiris' from the codebase and documentation.

## Capabilities

### New Capabilities
- `documentation-structure`: Defines requirements for project documentation, including correct repository and image references.

### Modified Capabilities
- `ci-publishing`: Update the target Docker Hub repository for image publishing.

## Impact

- README.md
- All files in `docs/`
- CI/CD workflow files (GitHub Actions)
- Docker metadata
