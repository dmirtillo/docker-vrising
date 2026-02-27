## Context

The repository has a CI pipeline that builds and publishes a Docker image when a new tag is pushed. However, it does not currently create a formal GitHub Release. The project maintains a `CHANGELOG.md` file, which is manually updated with release notes using a date-based heading format (e.g., `## [2026-02-28]`).

## Goals / Non-Goals

**Goals:**
- Automatically create a GitHub Release when a `v*.*.*` tag is pushed.
- Attach the relevant section of `CHANGELOG.md` to the release notes.

**Non-Goals:**
- Automating the generation of the `CHANGELOG.md` itself (it will remain manually curated).
- Modifying the existing Docker build/publish steps.

## Decisions

- **Use `softprops/action-gh-release`**: A standard and robust GitHub Action for creating releases.
- **Extract Changelog via `awk`**: Since the changelog uses a specific format (`## [YYYY-MM-DD]`), we can use a small `awk` script to extract the first section of the changelog to use as the release body. This avoids adding complex dependencies like custom changelog parser actions.

## Risks / Trade-offs

- [Risk] → If the `CHANGELOG.md` format changes or if a release is tagged without a corresponding top section in the changelog, the extracted notes might be incorrect or empty.
- [Mitigation] → The `awk` script will be written to extract the first block found between `## [` headers, which is a standard pattern. If it fails, the release will still be created, just with empty or partial notes, which can be manually edited later.
