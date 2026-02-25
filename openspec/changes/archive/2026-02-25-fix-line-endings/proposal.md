## Why

The `start.sh` script currently has CRLF line endings, which causes execution failures within the Linux-based Docker container. To work around this, a complex `entrypoint` involving `sed` is used in `docker-compose.yml`. This change aims to solve the root cause by enforcing LF line endings at the repository level and providing a safety net during the build process, allowing for a cleaner `docker-compose.yml`.

## What Changes

- **Repo Configuration**: Add a `.gitattributes` file to ensure `*.sh` files are always checked out with LF line endings.
- **Build Process**: Update the `Dockerfile` to include a `sed` command that removes any carriage returns from `/start.sh` during the image build, ensuring the script is always runnable regardless of the host environment.
- **Cleanup**: Simplify `docker-compose.yml` by removing the custom `entrypoint` hack, reverting to the default entrypoint defined in the `Dockerfile`.

## Capabilities

### New Capabilities
- `line-ending-management`: Infrastructure and build-time enforcement of LF line endings for shell scripts to ensure cross-platform compatibility.

### Modified Capabilities
- None

## Impact

- `Dockerfile`: Addition of a sanitization step for `start.sh`.
- `docker-compose.yml`: Removal of the complex `entrypoint` override.
- `.gitattributes`: New file to manage line endings.
- `start.sh`: Will be renormalized to LF in the repository.
