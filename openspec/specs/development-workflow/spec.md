# Development Workflow

## Purpose
Formalize the development process using the OpenSpec artifact-driven workflow to ensure high-quality, well-documented changes.

## Requirements

### Requirement: OpenSpec Workflow Documentation
The project SHALL document the OpenSpec artifact-driven workflow used for development to ensure consistency and transparency in how changes are proposed, designed, and implemented.

#### Scenario: New contributor wants to help
- **WHEN** a potential contributor reads the development guide
- **THEN** they find clear instructions on using OpenSpec commands (proposal, design, specs, tasks) to manage their changes

### Requirement: Standardized Change Process
All significant changes to the codebase SHOULD follow the artifact-driven workflow, moving through the Proposal, Design, Specification, and Task phases.

#### Scenario: Reviewing a change
- **WHEN** a maintainer reviews a pull request
- **THEN** they can reference the corresponding OpenSpec artifacts in the `openspec/changes/archive` or active `openspec/changes` folder to understand the rationale and technical decisions
