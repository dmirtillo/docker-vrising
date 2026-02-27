# Development & Contribution Guide

Welcome! If you're looking to contribute or understand how this project operates under the hood, this guide is for you.

## 📦 CI/CD Pipeline & Releases

The build and deployment process is fully automated using GitHub Actions.

### The `docker-image.yml` Pipeline
Every push to the `main` branch triggers the primary workflow, which consists of three jobs:
1. **Build:** Compiles the Docker image and pushes a temporary staging tag (using the commit SHA) to the GitHub Container Registry (GHCR).
2. **Test:** Pulls the staging image from GHCR and runs end-to-end tests (`scripts/test-startup.sh`) to ensure the server starts correctly.
3. **Publish (Only on Release):** If the workflow was triggered by a Git semantic version tag (e.g., `v1.0.0`), the tested image is pulled, tagged with the release version and `latest`, and pushed to Docker Hub for public consumption.

### How to Release
To release a new version of the image to Docker Hub:
1. Ensure all changes are merged into `main` and tests pass.
2. Create and push a new Git tag:
   ```bash
   git tag v1.x.x
   git push origin v1.x.x
   ```
3. The pipeline will automatically build, test, and publish the tagged image.

## 🧹 Maintenance: Automated Pruning

To keep our registries clean, we use a scheduled workflow (`.github/workflows/prune-registries.yml`) that runs every Sunday.

### What it does:
- **GHCR:** Deletes any untagged images (which accumulate when staging tags are overwritten).
- **Docker Hub:** Runs an API script to delete old, commit-SHA tagged images, preserving only `latest` and semantic version tags (`vX.X.X`).

### ⚠️ Required Secrets
For the automated GHCR pruning to work, a repository secret must be configured:
- **`PAT_WITH_DELETE_PACKAGES_SCOPE`**: A GitHub Personal Access Token created by an admin with the `delete:packages` scope. The default `GITHUB_TOKEN` does not have permission to delete packages.

---

## 🏗️ OpenSpec Artifact-Driven Workflow

This project uses **OpenSpec**, an experimental artifact-driven workflow, to manage significant changes. This ensures every change is deliberately proposed, designed, and specified before any code is written.

### Why OpenSpec?
OpenSpec creates a paper trail for the *intent* and *rationale* behind code changes. It breaks down complex ideas into manageable, trackable artifacts.

### The Process

1. **Start a New Change:**
   Use the Gemini CLI (or OpenSpec directly) to initialize a new change directory.
   ```bash
   /opsx:new add-new-feature
   ```
   This creates a folder in `openspec/changes/add-new-feature/`.

2. **Artifact Sequence:**
   You will be guided to create a series of Markdown documents:
   - **`proposal.md`**: *Why* are we doing this? What capabilities are affected?
   - **`design.md`**: *How* are we going to build it technically? (Decisions, Trade-offs)
   - **`specs/<capability>/spec.md`**: *What* exactly must it do? (Formal requirements and testable scenarios)
   - **`tasks.md`**: A trackable checklist of implementation steps.

3. **Implementation:**
   Once all artifacts are approved, the actual coding begins, using `tasks.md` as the source of truth.
   ```bash
   /opsx:apply
   ```

4. **Archive:**
   When the code is merged and tasks are complete, the change is archived. If any specs were modified, they are automatically synced to the main `openspec/specs/` directory, acting as living documentation for the project.
   ```bash
   /opsx:archive
   ```

If you are proposing a significant architecture shift or new feature, please draft a change proposal via OpenSpec!
