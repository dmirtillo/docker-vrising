## Context

The current `Dockerfile` relies on `apt-get install winehq-stable` and downloading the latest V Rising server files at build time without explicit version tracking. This means we only get updates when we manually trigger a build, and we don't know exactly what versions are in the image until we inspect it.

## Goals / Non-Goals

**Goals:**
- Automate the discovery of new Wine stable releases for Ubuntu Noble.
- Automate the discovery of new V Rising Dedicated Server builds via SteamCMD.
- Automatically create PRs that update explicit version arguments in the `Dockerfile`.
- Trigger the existing Docker build/publish pipeline when these PRs are merged.

**Non-Goals:**
- Automatically merging the PRs (human review is still required).
- Tracking updates for `winetricks` or `steamcmd` (they handle their own updates or don't need explicit tracking).

## Decisions

- **GitHub Actions for Cron Jobs**: We will use GitHub Actions with `schedule` triggers. Monthly for Wine (1st of the month) and weekly for V Rising (Sundays).
- **Explicit Version Tracking in Dockerfile**:
  - We will introduce `ARG WINE_VERSION="<version>"` and `ARG VRISING_BUILD_ID="<build_id>"` in the `Dockerfile`.
  - The Wine package installation will be pinned: `apt-get install -y --no-install-recommends winehq-stable=${WINE_VERSION}`.
  - The V Rising build ID is just a dummy argument to trigger a cache invalidation/rebuild, as the actual download happens via SteamCMD which always gets the latest if not cached.
- **Update Check Mechanisms**:
  - **Wine**: The action will add the WineHQ repo to the Ubuntu runner and use `apt-cache policy winehq-stable` to find the latest candidate.
  - **V Rising**: The action will query `https://api.steamcmd.net/v1/info/1828900` and parse the JSON for the `public` branch `buildid`.
- **PR Generation**: We will use the `peter-evans/create-pull-request` GitHub Action to commit the changes to the `Dockerfile` and open a PR.

## Risks / Trade-offs

- [Risk] The SteamCMD API might be rate-limited or go down.
  → Mitigation: The action will simply fail and retry next week. No impact on existing container stability.
- [Risk] Wine updates might break the server.
  → Mitigation: The PR requires manual review and merge. If a Wine update is known to be bad, the PR can be closed or delayed.
