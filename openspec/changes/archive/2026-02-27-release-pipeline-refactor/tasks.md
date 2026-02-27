## 1. Modify CI Pipeline

- [x] 1.1 Update `docker-image.yml` triggers to run on tags (e.g., `v*.*.*`) in addition to pushes and pull requests on `main`.
- [x] 1.2 Update the `publish` job condition to only execute if the workflow was triggered by a tag push (`startsWith(github.ref, 'refs/tags/')`).
- [x] 1.3 Modify the `publish` job to extract the semantic tag name and push to Docker Hub with that tag and the `latest` tag, instead of using the commit SHA.

## 2. Create Pruning Workflow

- [x] 2.1 Create `.github/workflows/prune-registries.yml` to run on a weekly schedule and via `workflow_dispatch`.
- [x] 2.2 Add a job to prune untagged packages from GHCR using a community action (e.g., `vlaurin/action-ghcr-prune`), utilizing a custom `PAT_WITH_DELETE_PACKAGES_SCOPE` secret.
- [x] 2.3 Add a step or job to prune untagged/old images from Docker Hub. (Note: This may require a script using the Docker Hub API or a specialized GitHub Action).

## 3. Documentation Updates

- [x] 3.1 Create `docs/development.md` documenting the CI/CD pipeline, release process, and maintenance tasks (including pruning).
- [x] 3.2 Document the **OpenSpec artifact-driven workflow** in `docs/development.md` (or a new `CONTRIBUTING.md`), including command usage and rationale.
- [x] 3.3 Add `docs/development.md` to the Documentation Index in `README.md`.
- [x] 3.4 Ensure documentation mentions the requirement for `PAT_WITH_DELETE_PACKAGES_SCOPE` for automated registry pruning.
