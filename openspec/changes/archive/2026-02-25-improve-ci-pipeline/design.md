## Context

The current GitHub Actions workflow (`docker-image.yml`) compiles the image and runs `test-startup.sh` in a single job. It does not publish the image anywhere. To automate releasing the container to users via Docker Hub (`dmirtillo/vrising-dedicated`), we must ensure tests pass first. A monolithic job is harder to maintain and lacks the efficiency of Docker Buildx caching.

## Goals / Non-Goals

**Goals:**
- Separate the CI pipeline into `build`, `test`, and `publish` jobs.
- Use Docker Buildx and GitHub Container Registry (`ghcr.io`) to securely pass the built image between jobs.
- Securely publish the validated image to Docker Hub (`dmirtillo/vrising-dedicated`) using GitHub Actions Secrets.
- Maintain local testing capability for developers.

**Non-Goals:**
- Implement semantic versioning (we will use `latest` and the commit SHA).
- Test on platforms other than Linux/amd64.

## Decisions

- **Image Passing Mechanism:** We will use `docker/build-push-action` to push the image to `ghcr.io` tagged with the commit SHA during the `build` phase. The `test` and `publish` phases will `docker pull` this exact SHA.
  - *Alternative Considered:* `docker save` and `docker load` via artifact upload/download. This was rejected because exporting/importing large tarballs is significantly slower than relying on registry caching.
- **Docker Hub Authentication:** Credentials will be managed via GitHub Secrets (`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`). These will only be injected into the `publish` job, providing robust isolation.
- **Test Script Adaptation:** The `scripts/test-startup.sh` will be updated. `IMAGE_NAME=${1:-"vrising-e2e-test"}`. If `$1` is missing, it runs `docker build -t "$IMAGE_NAME" .`. If provided, it skips the build.

## Risks / Trade-offs

- **GHCR Clutter:** Pushing an image to `ghcr.io` on every commit will consume storage. GitHub Packages has limits for private repositories, though it's free for public ones.
  - *Mitigation:* We can implement a package retention policy later if storage becomes an issue.