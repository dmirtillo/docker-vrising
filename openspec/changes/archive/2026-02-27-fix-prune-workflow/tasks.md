## 1. Fix GHCR Pruning Syntax

- [x] 1.1 In `.github/workflows/prune-registries.yml`, update the `vlaurin/action-ghcr-prune` step to use `prune-untagged: true` instead of the deprecated `untagged: true` parameter.

## 2. Update Documentation

- [x] 2.1 In `docs/development.md`, update the `Maintenance: Automated Pruning` section to explicitly state that the Docker Hub Personal Access Token requires Read, Write, and Delete permissions to successfully prune old staging tags.

## 3. Configure Dependabot

- [x] 3.1 Create `.github/dependabot.yml` to automatically manage updates for GitHub Actions and Docker dependencies on a weekly interval.
