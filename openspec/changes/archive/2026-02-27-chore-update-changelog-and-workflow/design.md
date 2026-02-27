## Context

The project has undergone several significant changes recently (CI improvements, SteamCMD fixes, environment standardization) which are not yet reflected in the `CHANGELOG.md`. Additionally, the branching and tagging strategy is mentioned in the rules of `openspec/config.yaml` but not formalized in a dedicated `workflow` section.

## Goals / Non-Goals

**Goals:**
- Reflect all recent 2026-02-25 and 2026-02-27 changes in `CHANGELOG.md`.
- Formalize the GitFlow branching and tagging strategy in `openspec/config.yaml`.

**Non-Goals:**
- Implement new features or fix bugs in the application code.

## Decisions

### 1. Changelog Updates
Add the following entries to `CHANGELOG.md` for `[2026-02-27]`:
- Optimized Ubuntu 24.04 and Wine environment for improved server stability.
- Standardized LF line endings for all container-internal scripts to prevent execution errors.
- Automated Steam license acceptance during Docker build process.
- Fixed SteamCMD configuration to ensure reliable server installation and updates.
- Improved CI/CD pipeline with automated E2E testing using Playwright and multi-platform build support.
- Standardized project structure and documentation.

### 2. Workflow Configuration
Add the following `workflow` section to `openspec/config.yaml`:
```yaml
workflow:
  branching:
    strategy: gitflow
    main: main
    develop: develop
    feature: feature/*
    release: release/*
    hotfix: hotfix/*
  tagging:
    enabled: true
    pattern: "v{version}"
    auto_tag_on_merge: true
```

## Risks / Trade-offs

- [Risk] Incorrect changelog entries. -> [Mitigation] Review archived changes to ensure accuracy before final commit.
- [Risk] Configuration format error. -> [Mitigation] Validate `openspec/config.yaml` after modification.
