## Context

The repository contains historical log files that are tracked by Git, leading to unnecessary bloat. The `README.md` is also cluttered with a long "Updates" section that functions as a changelog and should be moved to a standard `CHANGELOG.md` file.

## Goals / Non-Goals

**Goals:**
- Centralize historical updates in `CHANGELOG.md`.
- Ensure `logs/` are permanently ignored and removed from Git history.
- Maintain documentation integrity by removing broken links.

**Non-Goals:**
- Modifying the actual server logic or `start.sh` behavior.
- Moving the "Newest modifications" section (which serves as feature documentation).

## Decisions

- **Tool Choice**: `git-filter-repo` will be used instead of `git filter-branch` or `bfg-repo-cleaner` as it is the modern, faster, and safer standard recommended by Git.
- **README Update**: A link to `CHANGELOG.md` will be added to the bottom of the `README.md` or near where the "Updates" were, to maintain navigability.

## Risks / Trade-offs

- **Risk**: Rewriting history with `git-filter-repo` will change all commit hashes. This is a breaking change for anyone who has cloned the repository.
- **Mitigation**: This is a cleanup task; the user has explicitly requested this. After the operation, a force-push (`git push origin main --force`) will be necessary if a remote exists.
