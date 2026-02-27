## Context

The current `docker-image.yml` workflow pushes an image to GitHub Container Registry (GHCR) and Docker Hub every time a commit is pushed to the `main` branch. This creates a large volume of images tagged with Git commit SHAs, cluttering the public registries and making it difficult to find stable, semantic-versioned releases. While pushing to GHCR during the `build` phase is necessary to share the image with the `test` job across different GitHub Actions runners, these staging images do not need to persist permanently or be mirrored to Docker Hub unless they represent an official release.

## Goals / Non-Goals

**Goals:**
- Ensure Docker Hub is only updated when a semantic version tag (e.g., `v1.0.0`) is pushed.
- Maintain the current multi-job architecture (`build`, `test`, `publish`) in `docker-image.yml` to clearly distinguish CI phases in the GitHub UI.
- Continue using GHCR as a fast, temporary staging area for the `test` job to pull the image built in the `build` job.
- Implement automated pruning to delete untagged or staging images from GHCR and Docker Hub, keeping the registries clean.
- Create `docs/development.md` to provide a comprehensive guide for maintainers and contributors on how the CI/CD pipeline, releases, pruning, and the **OpenSpec development workflow** work.

**Non-Goals:**
- Removing the GHCR push step entirely during the build phase. (Alternative approaches like passing `.tar` artifacts between jobs were considered but rejected due to the significant performance overhead of downloading large Docker images).
- Modifying the underlying `Dockerfile` or `test-startup.sh` script.

## Decisions

- **Ephemeral Staging via GHCR**: We will continue pushing commit-SHA tagged images to GHCR in the `build` job. This is the fastest method to transfer the image to the `test` job running on a separate runner.
- **Conditional Publishing**: The `publish` job in `docker-image.yml` will be updated with an `if: startsWith(github.ref, 'refs/tags/')` condition. It will only pull the staging image from GHCR, tag it with the release version and `latest`, and push to Docker Hub (and permanently tag in GHCR) if a tag triggered the workflow.
- **Dedicated Pruning Workflow**: A new scheduled workflow (`.github/workflows/prune-registries.yml`) will be introduced. 
  - It will use the `vlaurin/action-ghcr-prune` action (or similar) to delete untagged packages from GHCR.
  - It will also include a job to prune old or untagged images from Docker Hub using a suitable community action or API script, ensuring both registries are kept tidy.

## Risks / Trade-offs

- **Risk**: Deleting packages from GHCR requires a Personal Access Token (PAT) with the `delete:packages` scope. The default `GITHUB_TOKEN` provided to actions does not have this permission.
  - **Mitigation**: The documentation/setup instructions will need to specify that repository maintainers must generate a PAT and store it as a secret (e.g., `GHCR_PRUNE_TOKEN`) for the pruning workflow to succeed.
- **Trade-off**: The GHCR registry will temporarily contain commit-SHA tags until the pruning workflow runs (e.g., daily or weekly). This is an acceptable trade-off for the performance benefits of using a registry for inter-job image transfer over file-based artifacts.
