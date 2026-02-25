## Context

The current `Dockerfile` fails during `apt-get install steamcmd` because the Steam License Agreement prompt is interactive and defaults to declining if not handled. To fix this, we need to pre-seed the `debconf` database with the acceptance of the license.

## Goals / Non-Goals

**Goals:**
- Automate the acceptance of the Steam License Agreement.
- Ensure the `Dockerfile` build is non-interactive and successful.

**Non-Goals:**
- Changing the base image.
- Refactoring the entire `RUN` block beyond what's necessary for the fix.

## Decisions

### Use `debconf-set-selections`
The most robust way to handle interactive prompts in Debian/Ubuntu-based Docker builds is `debconf-set-selections`. 

**Rationale:**
- It's the standard way to pre-configure packages before installation.
- It avoids the need for complex `expect` scripts or environment variable hacks that might not be supported by all packages.

**Alternatives:**
- `ENV STEAMCMD_QUESTION="I AGREE"`: While some packages support environment variables for configuration, `steamcmd` specifically relies on `debconf`.

## Risks / Trade-offs

- **[Risk]** The `debconf` keys could change in future versions of the `steamcmd` package.
  - **Mitigation:** Monitor build failures and update the keys if necessary. The current keys `steam/question` and `steam/license` are well-documented for this purpose.
