## Context

The repository's documentation is currently consolidated into a single `README.md` file. While comprehensive, the information density makes it difficult to navigate, especially for beginners looking for a quick start versus advanced users looking for complex configuration (like dynamic JSON patching). As the project grows, a monolithic README is no longer scalable.

## Goals / Non-Goals

**Goals:**
- Transition from a single-file README to a multi-file, "wiki-style" documentation structure stored directly in the repository under a `docs/` folder.
- Improve discoverability by categorically separating concerns (Installation, Configuration, Networking, Data, Troubleshooting).
- Maintain all existing information without losing details during the split.

**Non-Goals:**
- Creating a separate GitHub Wiki (which is isolated from the main git history and PR process).
- Writing new documentation content (this is a structural refactor of existing content).

## Decisions

- **Folder Structure**: A `docs/` folder will be created in the root repository. This ensures documentation is version-controlled alongside the code that requires it.
- **File Granularity**: 
  - `docs/installation.md`: Quickstart Docker/Compose examples.
  - `docs/configuration.md`: Environment variables, Advanced JSON config, RCON.
  - `docs/networking.md`: Ports, routing, and visibility.
  - `docs/data-management.md`: Volumes, saves, and migrations.
  - `docs/troubleshooting.md`: Logs, known issues (Windows host), and quirks.
- **Root README**: The root `README.md` will be stripped down to act as a landing page. It will retain the logo, badges, a short introduction, and an explicit Table of Contents linking to the `docs/` files.

## Risks / Trade-offs

- **Broken External Links**: If external sites link directly to specific anchors in the old `README.md` (e.g., `README.md#environment-variables`), those links will break.
  - *Mitigation*: This is a one-time structural cost that provides long-term maintainability. We will ensure the new root README is clear enough that users can easily find the new locations.