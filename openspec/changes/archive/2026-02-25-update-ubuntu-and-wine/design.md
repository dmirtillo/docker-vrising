## Context

The current `Dockerfile` is based on Ubuntu 22.04 and installs the default `wine` package from the Ubuntu repositories. This version is often significantly behind the official WineHQ releases, which can cause issues with modern Windows games like V Rising. Ubuntu 24.04 (Noble Numbat) is now available as a stable LTS release, offering updated system components.

## Goals / Non-Goals

**Goals:**
- Update the base image to Ubuntu 24.04.
- Transition to using WineHQ's official repositories for Wine installation.
- Ensure the container remains stable and functional for hosting V Rising.

**Non-Goals:**
- Migrating from SteamCMD to another tool.
- Major refactoring of the initialization scripts (unless required by the OS update).

## Decisions

### Base Image Update
- **Decision:** Upgrade `FROM ubuntu:22.04` to `FROM ubuntu:24.04`.
- **Rationale:** Standardizing on the latest LTS release ensures long-term support and access to newer system libraries (glibc, etc.) which may be required by newer Wine versions.

### Wine Installation Method
- **Decision:** Add the WineHQ official repository and install `winehq-stable`.
- **Rationale:** This ensures we get the latest stable version of Wine directly from the maintainers, which includes better compatibility fixes for Windows applications.
- **Alternatives Considered:**
    - Stay with Ubuntu repositories: Rejected because they are too slow to update.
    - Use `winehq-staging`: Rejected to maintain production stability, although it offers newer features.

### GPG Key Management
- **Decision:** Download the WineHQ GPG key and store it in `/etc/apt/keyrings/winehq-archive.key` following modern Debian/Ubuntu best practices.
- **Rationale:** Newer Ubuntu versions deprecate `apt-key` in favor of specific keyrings.

## Risks / Trade-offs

- **[Risk]** Package name changes in Ubuntu 24.04 → **Mitigation:** Verify all current dependencies (e.g., `libgl1-mesa-glx:i386`) exist in the Noble repositories or find their replacements.
- **[Risk]** Dependency conflicts between WineHQ and Ubuntu packages → **Mitigation:** Use `apt-get install --install-recommends` carefully and ensure architectures are added correctly before repository setup.
- **[Risk]** Increased build time → **Mitigation:** Consolidate commands into a single `RUN` layer to keep the image size optimized.
