## ADDED Requirements

### Requirement: Automated GitHub Releases
The pipeline SHALL automatically create a GitHub Release when a `v*.*.*` semantic version tag is pushed.
- The release MUST automatically generate release notes containing the commit messages/PRs since the last tag.
- The release MUST be created using the `GITHUB_TOKEN` provided by the Actions runner.

#### Scenario: Creating a release on tag push
- **WHEN** a semantic version tag (e.g., `v1.0.0`) is pushed and tests pass
- **THEN** a GitHub Release is created for the tag
- **THEN** the release body contains the auto-generated commit log
