## Context

V Rising server under Wine takes several minutes to fully start, generating the world and loading save data. During this time, the server query port (UDP) might be closed. Users who want to run an RCON sidecar container need a way for that container to know when it is safe to execute commands against the server. Currently, there's no native healthcheck in the Docker image.

## Goals / Non-Goals

**Goals:**
- Implement a Docker `HEALTHCHECK` that accurately reflects the V Rising server's availability using the UDP query port.
- Install necessary dependencies (`netcat-openbsd`) in the Docker image for the healthcheck.
- Document a `docker-compose.yml` pattern that runs a `gorcon/rcon-cli` sidecar container which waits for the `vrising` container to be healthy.

**Non-Goals:**
- Creating a custom healthcheck bash script that parses logs (too brittle).
- Changing the default application ports.

## Decisions

- **Use `netcat` (nc) for UDP Ping**: We will install `netcat-openbsd` in the final image and use `nc -z -u 127.0.0.1 ${QUERYPORT:-9877}` as the healthcheck command. It's simple, lightweight, and doesn't rely on parsing potentially volatile log formats.
- **Generous Start Period**: The `HEALTHCHECK` will be configured with a long `start_period` (e.g., 120s) to accommodate the notoriously slow Wine/V Rising boot sequence without prematurely marking the container as unhealthy.

## Risks / Trade-offs

- [Risk] → `nc -z -u` on UDP is connectionless and might falsely report success if a firewall drops packets silently.
- [Mitigation] → Since the check runs inside the container against `127.0.0.1`, there is no firewall interference. It should reliably detect if the port is open and listening.
