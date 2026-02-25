## 1. Update Test Script

- [x] 1.1 Update `scripts/test-startup.sh` to accept an optional image name as `$1`.
- [x] 1.2 Update the script logic: Only run `docker build` if `$1` is NOT provided, otherwise use the provided image name.

## 2. Refactor GitHub Actions Workflow

- [x] 2.1 Update `.github/workflows/docker-image.yml` to define three consecutive jobs: `build`, `test`, and `publish`.
- [x] 2.2 Configure the `build` job to use `docker/setup-buildx-action`, `docker/login-action` (for `ghcr.io`), and `docker/build-push-action` to push the built image to GHCR tagged with `${{ github.sha }}`.
- [x] 2.3 Configure the `test` job to `needs: build`, log in to `ghcr.io`, pull the image from GHCR, and execute `./scripts/test-startup.sh` passing the GHCR image name.
- [x] 2.4 Configure the `publish` job to `needs: test` and only run on pushes to `main`.
- [x] 2.5 In the `publish` job, authenticate with `ghcr.io` and Docker Hub (using `secrets.DOCKERHUB_USERNAME` and `secrets.DOCKERHUB_TOKEN`).
- [x] 2.6 In the `publish` job, pull the image from GHCR, retag it as `dmirtillo/vrising-dedicated:latest` and `dmirtillo/vrising-dedicated:${{ github.sha }}`, and push both tags to Docker Hub.