## Why

Updating to Ubuntu 24.04 ensures the container uses the latest LTS release with modern system libraries and extended support. Switching to WineHQ repositories allows us to pull the latest stable Wine versions, which are essential for compatibility and performance with V Rising, as the default Ubuntu wine packages often lag behind.

## What Changes

- Update the base image from `ubuntu:22.04` to `ubuntu:24.04`.
- Add the official WineHQ repository and its GPG key to the package manager.
- Replace the installation of the default Ubuntu `wine` package with `winehq-stable` (or latest available version).
- Update dependency handling to accommodate changes in Ubuntu 24.04 package names if necessary.

## Capabilities

### New Capabilities
- `wine-management`: Manages the installation of Wine from WineHQ repositories and handles GPG key registration.

### Modified Capabilities
<!-- Existing capabilities whose REQUIREMENTS are changing (not just implementation).
     Only list here if spec-level behavior changes. Each needs a delta spec file.
     Use existing spec names from openspec/specs/. Leave empty if no requirement changes. -->

## Impact

- `Dockerfile`: Base image and package installation logic will be modified.
- Build Process: Adding external repositories increases build complexity and adds a dependency on WineHQ infrastructure.
- Runtime: Newer Wine versions might require adjustments to environment variables or initialization scripts.
