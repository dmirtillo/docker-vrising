## Context

Currently, `winetricks` is installed via `apt-get` from the Ubuntu Noble repository. This version is often outdated, lacking support for newer Wine versions or specific game requirements. V Rising benefits from the latest `winetricks` for optimal compatibility.

## Goals / Non-Goals

**Goals:**
- Provide the latest `winetricks` version in the Docker image.
- Create a reusable update script within the image.
- Ensure bash completion is available for `winetricks`.

**Non-Goals:**
- Managing other Wine-related tools (like `wine` itself) beyond standard package installation.
- Providing a GUI for `winetricks`.

## Decisions

### Decision 1: Install from Source (GitHub)
**Rationale:** The official `winetricks` GitHub repository is the source of truth and receives frequent updates.
**Alternatives Considered:**
- **Ubuntu Repo:** Outdated, the primary reason for this change.
- **PPA:** Might not always be up-to-date or maintained for the latest Ubuntu versions.

### Decision 2: Use a Dedicated Update Script
**Rationale:** Encapsulating the download and installation logic in a script (`update_winetricks`) makes it repeatable and easier to maintain. It also allows users to manually update `winetricks` inside a running container if needed.
**Implementation Detail:** The script will use `wget` to fetch `winetricks` and its completion script, then move them to `/usr/bin/` and `/usr/share/bash-completion/completions/` respectively.

### Decision 3: Remove `winetricks` from `apt-get install`
**Rationale:** To avoid conflicts and ensure the source-built version is the one being used, the package must be removed from the standard installation list.

## Risks / Trade-offs

- **[Risk] GitHub Availability** → **Mitigation**: Build will fail if GitHub is down, but this is a standard risk for many source-based builds.
- **[Risk] Incompatibility with future Wine versions** → **Mitigation**: Source-built `winetricks` is generally more compatible with newer Wine than the repo version.
