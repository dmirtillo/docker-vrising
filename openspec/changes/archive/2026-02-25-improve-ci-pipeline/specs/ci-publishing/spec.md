## ADDED Requirements

### Requirement: Multi-Stage CI Pipeline
The GitHub Actions workflow SHALL be separated into consecutive `build`, `test`, and `publish` jobs.
- The `test` job must `needs: build`.
- The `publish` job must `needs: test`.

#### Scenario: Workflow execution
- **WHEN** the CI pipeline runs
- **THEN** the `build` job executes first, followed by `test`, and optionally `publish` if conditions are met.

### Requirement: Docker Hub Publishing
The pipeline SHALL automatically push successful images to Docker Hub (`dmirtillo/vrising-dedicated`).
- The `publish` job must only execute on the `main` branch.
- Must authenticate using `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
- Must tag and push both `latest` and a unique commit SHA tag.

#### Scenario: Pushing to main
- **WHEN** a commit is pushed to the `main` branch and tests pass
- **THEN** the image is pushed to Docker Hub with `latest` and the commit SHA tag

#### Scenario: Pull request execution
- **WHEN** the pipeline runs on a pull request
- **THEN** the `publish` job is skipped