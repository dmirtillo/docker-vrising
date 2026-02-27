## Context

The project was originally hosted under the `trueosiris` namespace. It has now been transferred to `dmirtillo`. All external references, including the GitHub repository URL and Docker Hub image path, must reflect this change to ensure users are directed to the correct resources and that CI/CD pipelines function correctly.

## Goals / Non-Goals

**Goals:**
- Update all documentation (README.md and `docs/*.md`) with the new repository URL: `github.com/dmirtillo/docker-vrising`.
- Update all Docker Hub image references to `dmirtillo/vrising-dedicated`.
- Remove or replace any leftover references to 'trueosiris' in the codebase.
- Update GitHub Actions workflows to point to the new Docker Hub repository.

**Non-Goals:**
- No functional changes to the server startup scripts or Dockerfile logic.
- No structural changes to the documentation.

## Decisions

- **Global Search and Replace**: Use regex-based search to identify all occurrences of `trueosiris` and `trueosiris/docker-vrising` to ensure complete coverage.
- **CI/CD Update**: Explicitly update the `IMAGE_NAME` or equivalent variables in `.github/workflows/` to use the new Docker Hub path.

## Risks / Trade-offs

- **Broken Links**: Users following old documentation might find broken links.
  - [Risk] → Mitigation: Ensure the main entry point (README.md) is updated first and clearly state the move.
- **CI/CD Failure**: Pushing to the new Docker Hub repository requires appropriate permissions/secrets in the new GitHub repository.
  - [Risk] → Mitigation: Include a task to verify CI/CD settings after implementation.
