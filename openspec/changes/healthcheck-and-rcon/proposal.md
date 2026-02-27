## Why

Currently, checking if the V Rising server is fully initialized is difficult, and users must run an ephemeral Docker container to execute RCON commands. Introducing a formal Docker `HEALTHCHECK` using the UDP query port allows other services (like an RCON sidecar) to reliably wait for the server to be ready before starting. 

## What Changes

- Add a `HEALTHCHECK` instruction to the Dockerfile (or provide it as an explicit recommendation in docker-compose.yml) using `nc -z -u` against the server's Query Port.
- Provide a `docker-compose.yml` example in the documentation that sets up the V Rising server alongside a persistent `gorcon/rcon-cli` sidecar container that depends on the server's health status.
- Ensure `netcat-openbsd` or a similar tool is available in the final Docker image stage for the healthcheck to function.

## Capabilities

### New Capabilities
- `container-healthcheck`: The ability for the container to accurately report its readiness state to the Docker daemon.

### Modified Capabilities
- `documentation-structure`: Updating requirements to include a docker-compose setup with an RCON sidecar relying on the new healthcheck.

## Impact

- `Dockerfile` (install `netcat-openbsd` and optionally add `HEALTHCHECK`)
- `docs/configuration.md` (add new docker-compose example)
