## Why

The build is currently failing because the Steam License Agreement is being declined during the installation of `steamcmd`. To allow automated builds, we need to pre-accept this license using `debconf-set-selections`.

## What Changes

- Modify the `Dockerfile` to include `debconf-set-selections` commands that pre-accept the Steam License Agreement.
- Ensure these commands are placed before the `apt-get install` that includes `steamcmd`.

## Capabilities

### New Capabilities
- `steam-license-management`: Automatically handling the Steam License Agreement for headless installations.

### Modified Capabilities
- None

## Impact

- `Dockerfile`: The main build instructions will be updated.
- Build process: The `docker compose build` should now complete successfully without manual intervention.
