## Context

The registry pruning workflow recently added in the `release-pipeline-refactor` is encountering errors. The GHCR pruning job is failing because `vlaurin/action-ghcr-prune` updated its syntax (deprecating `untagged` in favor of `prune-untagged`), which in turn cascades into a missing token error. Furthermore, the Docker Hub script successfully authenticates and lists tags but receives a `403 Forbidden` response when trying to delete them. This indicates the Docker Hub Personal Access Token lacks the necessary scopes (Read, Write, Delete). We also want to integrate Dependabot to ensure our CI/CD workflows and Docker dependencies stay up-to-date.

## Goals / Non-Goals

**Goals:**
- Fix the syntax warning/error in `.github/workflows/prune-registries.yml` for the GHCR pruning action.
- Update the development documentation (`docs/development.md`) to clearly specify the required token permissions for the `DOCKERHUB_TOKEN` secret to ensure pruning functionality.
- Add automated dependency management using Dependabot for GitHub Actions and Docker.

**Non-Goals:**
- Modifying the core logic of the Docker Hub pruning script (the shell script itself works as intended).
- Changing the Docker image build or publishing processes.

## Decisions

- **GHCR Syntax Fix**: Change `untagged: true` to `prune-untagged: true` in `.github/workflows/prune-registries.yml`.
- **Documentation Update**: Add explicit language to `docs/development.md` explaining that the `DOCKERHUB_TOKEN` must be a Personal Access Token with at least "Read, Write, Delete" permissions to allow the pruning script to remove old commit-SHA tags.
- **Dependabot Integration**: We will introduce a `.github/dependabot.yml` configuration to keep GitHub Actions (`github-actions`) and Docker base images (`docker`) up-to-date with a weekly schedule.

## Risks / Trade-offs

- **Risk**: Users might be using their Docker Hub account passwords instead of Access Tokens. Passwords generally do not work with API deletion requests where scopes are strictly enforced.
  - **Mitigation**: The documentation will explicitly state the need for an Access Token with specific permissions.
- **Risk**: Automated Dependabot PRs might cause CI failures if a major dependency update introduces breaking changes.
  - **Mitigation**: Existing CI tests (like `test-startup.sh`) will automatically run on Dependabot PRs, allowing maintainers to catch breaking changes before merging.
