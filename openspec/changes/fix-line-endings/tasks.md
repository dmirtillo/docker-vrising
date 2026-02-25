## 1. Repo Configuration

- [x] 1.1 Create `.gitattributes` file to enforce LF line endings for `*.sh` files.
- [x] 1.2 Renormalize `start.sh` line endings to LF.

## 2. Build Process Fix

- [x] 2.1 Update `Dockerfile` to include `RUN sed -i 's/\r$//' /start.sh` as a safety net.
- [x] 2.2 Verify the image builds successfully. (Skipped by user)

## 3. Configuration Cleanup

- [x] 3.1 Update `docker-compose.yml` to remove the complex `entrypoint` with `sed`.
- [x] 3.2 Verify the container starts correctly with the simplified configuration. (Skipped by user)
