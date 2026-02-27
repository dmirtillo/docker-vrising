## 1. Dockerfile Updates

- [x] 1.1 Install `netcat-openbsd` in the `final` stage of the `Dockerfile`
- [x] 1.2 Add the `HEALTHCHECK` instruction to the `Dockerfile` querying `127.0.0.1` on `${QUERYPORT:-9877}` via UDP.

## 2. Documentation Updates

- [x] 2.1 Update `docs/configuration.md` to include a new section explaining the healthcheck
- [x] 2.2 Add a `docker-compose.yml` example to `docs/configuration.md` showing how to run the `gorcon/rcon-cli` sidecar with `depends_on: service_healthy`
- [x] 2.3 Update `docs/installation.md` and root `docker-compose.yml` with healthcheck examples
