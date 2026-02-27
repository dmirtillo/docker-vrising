## Why

The current `openspec/config.yaml` mixes technical constraints (e.g., line endings, Wine compatibility) with workflow instructions (e.g., gitflow usage, changelog updates). Furthermore, some rules are redundant as they are already explicitly defined in the `workflow` configuration section. This lack of separation and clarity makes the configuration harder to maintain and leads to validation warnings.

## What Changes

- **Refactor**: Split the `rules` list into `workflow.guidelines` (process-oriented) and `constraints` (technical requirements).
- **Cleanup**: Remove redundant rules that are already covered by `workflow.branching` and `workflow.tagging` settings.
- **Organization**: Rename the top-level `rules` key to `constraints` to clearly identify technical requirements versus process guidelines.
- **Fix**: Resolve validation warnings regarding the `context` and `rules` fields in `config.yaml`.

## Capabilities

### New Capabilities
- None.

### Modified Capabilities
- None.

## Impact

This change only affects `openspec/config.yaml` and does not impact the project's source code or existing specifications. It improves the clarity and maintainability of the OpenSpec configuration.
