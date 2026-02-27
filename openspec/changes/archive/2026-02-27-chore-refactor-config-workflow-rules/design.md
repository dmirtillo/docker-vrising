## Context

The `openspec/config.yaml` file is the central configuration for the OpenSpec workflow in this project. Currently, the `rules` section is a flat list that mixes technical requirements and workflow process instructions. Some of these instructions are redundant with existing YAML keys in the `workflow` section. Validation warnings also indicate that the current schema expects different types for `context` and `rules`.

## Goals / Non-Goals

**Goals:**
- Separate technical constraints from workflow guidelines.
- Eliminate redundancy in the configuration.
- Resolve schema validation warnings.

**Non-Goals:**
- Changing the actual project requirements or workflow branching/tagging logic.
- Adding new features to the project.

## Decisions

### 1. Structure of `workflow`
Move process-oriented rules to `workflow.guidelines`.
- **Rationale**: Keeps process documentation together with process configuration.
- **Moved Items**:
  - "Document all changes in the respective files under docs/ directory..."
  - "Update changelog at each main specification change..."

### 2. Introduce `constraints` Section
Rename the current `rules` section to `constraints` and keep only technical requirements.
- **Rationale**: "Constraints" more accurately describes technical requirements like line endings or port exposures.
- **Items**:
  - LF line endings
  - Wine compatibility
  - Persistent data
  - Docker image size
  - UDP ports

### 3. Remove Redundancy
Remove the following items from the config entirely:
- "Use gitflow..." (already covered by `workflow.branching.strategy`)
- "Tag application release..." (already covered by `workflow.tagging.enabled`)
- **Rationale**: Avoiding "single source of truth" violations where instructions in a list might diverge from functional YAML configuration.

### 4. Resolve Validation Issues
- Change `context` to a formatted string instead of a nested object to satisfy schema requirements.
- Ensure `constraints` (formerly `rules`) is used correctly. (Note: if the schema doesn't know `constraints`, it might ignore it, which is fine as it's for human/AI context).

## Risks / Trade-offs

- **Risk**: Tooling might explicitly expect a `rules` key.
- **Mitigation**: We will monitor if moving them to `constraints` or `workflow.guidelines` causes issues. If the tool requires `rules` to be an object, we can structure it as `rules: { item: description }`.
