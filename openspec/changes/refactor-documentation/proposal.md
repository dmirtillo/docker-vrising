## Why

The current `README.md` is a monolithic, dense document that mixes quick-start instructions with advanced dynamic JSON patching and edge-case troubleshooting. This makes it difficult for new users to get started quickly and hard for advanced users to find specific configuration details. Moving to a structured, multi-file documentation approach will significantly improve readability and maintainability.

## What Changes

- Create a `docs/` directory to house categorized markdown files.
- Split the existing `README.md` content into focused documents:
  - `docs/installation.md`: Quick start, Docker CLI, and Docker Compose examples.
  - `docs/configuration.md`: Environment variables, dynamic JSON patching, and RCON.
  - `docs/networking.md`: Ports, port forwarding, and custom port overrides.
  - `docs/data-management.md`: Volumes, persistence, and migrating local saves.
  - `docs/troubleshooting.md`: Windows host issues, harmless log warnings, etc.
- Refactor the main `README.md` to serve as a clean landing page with badges, a brief description, and a clear index linking to the files in the `docs/` directory.

## Capabilities

### New Capabilities
- `documentation-structure`: Define requirements for the multi-file documentation architecture and index linking.

### Modified Capabilities
<!-- None -->

## Impact

- **User Experience**: Users will have a much easier time navigating the documentation, acting like a built-in wiki.
- **Maintainability**: Future additions to the documentation can be added to specific files rather than bloating a single README.
- **Repository Structure**: Addition of the `docs/` folder to the root of the repository.