## ADDED Requirements

### Requirement: Repository URL Consistency
All project documentation and README files SHALL refer to the repository using the URL `github.com/dmirtillo/docker-vrising`.

#### Scenario: Update README repository links
- **WHEN** the README.md is checked
- **THEN** all repository links point to `github.com/dmirtillo/docker-vrising`

#### Scenario: Update docs repository links
- **WHEN** any file in the `docs/` directory is checked
- **THEN** all repository links point to `github.com/dmirtillo/docker-vrising`

### Requirement: Docker Hub Image URL Consistency
All project documentation SHALL refer to the official Docker Hub image as `dmirtillo/vrising-dedicated`.

#### Scenario: Update installation guide image reference
- **WHEN** `docs/installation.md` is checked
- **THEN** the Docker image reference is `dmirtillo/vrising-dedicated`

#### Scenario: Update README image badges
- **WHEN** README.md badges are checked
- **THEN** they point to `dmirtillo/vrising-dedicated` on Docker Hub

### Requirement: Removal of Legacy Namespace
The project SHALL NOT contain references to the legacy `trueosiris` namespace in documentation or image paths.

#### Scenario: Search for legacy namespace
- **WHEN** a global search for `trueosiris` is performed
- **THEN** no results are found in documentation or README files
