## Context

The V Rising server is complex to set up correctly, requiring Ubuntu, Wine, Xvfb, and SteamCMD to all initialize in sequence. We recently fixed a bug where Wine initialization hung on headless prompts. Without E2E tests, this sort of regression could easily happen again. We need a way to run a test container and verify that the server logs eventually report a successful startup.

## Goals / Non-Goals

**Goals:**
- Provide a local bash script to build and test the container.
- Run the test in a GitHub Actions workflow on PRs and pushes to `main`.
- Automate checking the logs for the `Startup Completed` message.
- Handle timeouts gracefully and clean up test containers.

**Non-Goals:**
- Test joining the server with a game client.
- Test in-game logic or commands.
- Support testing on Windows natively (we test the Linux Docker image).

## Decisions

- **Test Approach**: We will use a standard bash script (`scripts/test-startup.sh`) using the Docker CLI rather than a complex test framework. It's lightweight, easy to run locally, and trivial to integrate into GitHub Actions.
- **Log Verification**: The script will start the container detached, then enter a loop using `docker logs` and `grep` to look for the "Startup Completed" string.
- **Timeouts**: We will implement a `timeout` loop inside the script (e.g., checking every 5 seconds up to 10 minutes) since SteamCMD downloads can take a while depending on network conditions.
- **Cleanup**: We will use `docker rm -f` in a `trap` or at the end of the script to ensure the test container is always removed, regardless of pass/fail.

## Risks / Trade-offs

- **Download Times**: SteamCMD downloads a large game server. This means the CI pipeline will take 5-10 minutes to complete. We accept this trade-off for the confidence the test provides.
- **Flakiness**: Steam servers can occasionally be slow or timeout. The 10-minute timeout should be generous enough to account for network variability.