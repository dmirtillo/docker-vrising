## Why

The current documentation provides a good foundation for Docker users, but lacks clear scenario-based examples, explicit troubleshooting for common dedicated server issues, and straightforward explanations of advanced features (like RCON via environment variables). We need to overhaul the documentation to reduce user friction, decrease the number of common questions/issues, and provide a "plug-and-play" experience with easy-to-use Docker Compose templates.

## What Changes

- Add scenario-based configuration sets ("recipes") for Solo/Duo, PvE, and PvP to the installation guide.
- Provide clear instructions on managing admins via `adminlist.txt`.
- Add documentation on enabling RCON purely through environment variables and using temporary Docker containers for execution.
- Add an automated backup script example using `cron` to `data-management.md`.
- Enhance the troubleshooting section with specific steps for the "Server Not Showing in List" issue and "Save Corruption & Rollbacks".
- Add a clear disclaimer regarding modding (BepInEx) support in the Docker image.

## Capabilities

### New Capabilities

### Modified Capabilities
- `documentation-structure`: Updating requirements to include scenario-based recipes, comprehensive RCON environment variable usage, cron backup examples, modding disclaimers, and expanded troubleshooting guides.
- `server-installation`: Expanding requirements for server installation to include different pre-configured Docker Compose examples based on playstyle.

## Impact

- `docs/installation.md`
- `docs/configuration.md`
- `docs/troubleshooting.md`
- `docs/data-management.md`
