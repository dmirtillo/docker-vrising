## Why

During the automated E2E tests, the `test-startup.sh` script fails to clean up the temporary test directory on the host machine. This happens because the Docker container runs internally as the `steam` user, creating files in the mounted volume that are owned by the container's user ID. When the host script attempts to run `rm -rf` on the test directory, it encounters "Permission denied" and "Device or resource busy" errors, leaving orphaned test directories behind and failing the CI step.

## What Changes

- Update the `cleanup()` function in `scripts/test-startup.sh`.
- Instead of attempting to `rm -rf` directly from the host runner, spin up a short-lived Docker container (`ubuntu:24.04`) that mounts the test directory and deletes its contents as the `root` user from within the container.
- Ensure hidden files and subdirectories are correctly purged before attempting to remove the root test directory on the host.

## Capabilities

### New Capabilities
<!-- None -->

### Modified Capabilities
- `automated-testing`: Update the local test script requirement to explicitly handle privileged volume cleanup.

## Impact

- **CI/CD**: The GitHub Actions runner will no longer fail at the end of successful tests, and disk space will be correctly reclaimed.
- **Development**: Developers running the script locally won't be left with undeletable root-owned folders in their `/tmp/` directory.