## Why

Winetricks should not be installed from the main Ubuntu repositories as it is often outdated. Installing from the official source ensures we have the latest version with better compatibility and bug fixes for Wine applications like V Rising.

## What Changes

- Remove `winetricks` package from the standard `apt-get install` list in the `Dockerfile`.
- Add a custom script `update_winetricks` that downloads the latest `winetricks` and its bash-completion from GitHub.
- Install the `update_winetricks` script to `/usr/bin/` for easy manual updates.
- Execute the `update_winetricks` script during the build process to ensure the latest version is present in the final image.

## Capabilities

### New Capabilities
- `winetricks-management`: Management of winetricks installation from source and update mechanism.

### Modified Capabilities
- `winehq-management`: (Internal note: although winehq-stable is currently in `wine-management`, this change affects how wine-related tools are managed).

## Impact

- `Dockerfile`: Modified to handle winetricks installation differently.
- `/usr/bin/winetricks`: Will now be the latest version from source instead of the apt package.
- `/usr/bin/update_winetricks`: New utility available in the container.
