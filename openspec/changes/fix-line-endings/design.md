## Context

The `start.sh` script is the main entrypoint for the V-Rising server container. If it contains CRLF (`\r\n`) line endings, the Linux shell will fail to execute it properly, typically throwing "No such file or directory" because it's looking for `/bin/bash\r`.
Currently, the `docker-compose.yml` file uses a complex `entrypoint` to fix the file at runtime. This is inefficient and adds unnecessary complexity to the orchestration layer.

## Goals / Non-Goals

**Goals:**
- Fix line endings at the source (Git) and during the build (Dockerfile).
- Simplify `docker-compose.yml` by removing the `entrypoint` hack.
- Ensure the image remains portable and robust across different host operating systems.

**Non-Goals:**
- Modifying the functionality of `start.sh`.
- Changing the base image.

## Decisions

### Decision 1: Repository-level line ending enforcement
**Rationale:** Using `.gitattributes` ensures that Git always treats shell scripts as having LF line endings, regardless of the developer's local Git configuration (`core.autocrlf`).
**Alternatives:** Relying on developer education or local IDE settings (too brittle).

### Decision 2: Build-time sanitization
**Rationale:** Adding `RUN sed -i 's/\r$//' /start.sh` to the `Dockerfile` provides a final safety net. If a file somehow bypasses Git normalization (e.g., added manually or via a different tool), the Docker image will still be functional.
**Alternatives:** Using `dos2unix` (requires installing an extra package). `sed` is already available.

### Decision 3: Remove `docker-compose.yml` entrypoint override
**Rationale:** Once the `Dockerfile` and repository are fixed, the `entrypoint` hack is redundant. Reverting to the `Dockerfile`'s default `CMD` or a standard `entrypoint` makes the configuration cleaner and less error-prone.
**Alternatives:** Keep the hack "just in case" (increases tech debt).

## Risks / Trade-offs

- **[Risk] Git Renormalization**: Adding `.gitattributes` can sometimes cause large diffs if many files are affected.
- **[Mitigation]**: We only target `*.sh` files, and we will perform a manual renormalization commit.
