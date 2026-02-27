## 1. Refactor openspec/config.yaml

- [x] 1.1 Move workflow-related rules to `workflow.guidelines` list.
- [x] 1.2 Rename top-level `rules` section to `constraints`.
- [x] 1.3 Filter out redundant rules ("Use gitflow", "Tag application release").
- [x] 1.4 Convert `context` field to a multiline string to resolve validation warnings.
- [x] 1.5 Verify that all technical requirements (LF endings, Wine compatibility, ports, etc.) are preserved in the `constraints` section.

## 2. Validation

- [x] 2.1 Run `openspec status` to verify that the refactored `config.yaml` no longer triggers validation warnings.
