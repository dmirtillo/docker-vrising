## Context

The previous attempt to pin Wine to version 10 failed with "unmet dependencies" because `apt` requires explicit pinning of sub-packages when a metapackage like `winehq-stable` is pinned.

## Goals / Non-Goals

**Goals:**
- Upgrade Wine to version 11.0.
- Fix the `apt` dependency resolution issue in the `Dockerfile`.

## Decisions

- **Explicit Sub-package Pinning**: We will pin `winehq-stable`, `wine-stable`, `wine-stable-amd64`, and `wine-stable-i386` to `${WINE_VERSION}`.
- **Update WINE_VERSION**: Set the default `ARG` to `11.0.0.0~noble-1`.

## Risks / Trade-offs

- [Risk] Wine 11 might have regressions for V Rising.
  → Mitigation: The automated E2E tests in the CI pipeline will verify if the server still starts correctly.
