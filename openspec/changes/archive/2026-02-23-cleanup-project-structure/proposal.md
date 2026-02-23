## Why

The current project structure has a cluttered `README.md` containing a long changelog section ("Updates") and an outdated reference to a log file. Furthermore, the `logs/` directory is currently tracked by Git, which increases repository size and includes ephemeral data in the version history.

## What Changes

- **Move Changelog**: Extract the "Updates" section from `README.md` into a new `CHANGELOG.md` file.
- **Update README.md**: Clean up the "Updates" section and remove the broken link to the sample log file.
- **Update .gitignore**: Add `logs/` to the ignore list to prevent future tracking.
- **Purge History**: Use `git-filter-repo` to remove the `logs/` directory and its contents from the entire Git history.

## Capabilities

### New Capabilities
<!-- None -->

### Modified Capabilities
<!-- None -->

## Impact

- **Project Structure**: Addition of `CHANGELOG.md` and cleaner `README.md`.
- **Git Repository**: The history will be rewritten (breaking for clones).
- **Documentation**: Links to the sample log in `README.md` will be removed.
