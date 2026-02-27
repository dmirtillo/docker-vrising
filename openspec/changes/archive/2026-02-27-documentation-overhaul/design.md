## Context

The V Rising dedicated server in this repository has robust capabilities for dynamic configuration (JSON patching via environment variables) and clean containerized structure. However, the existing documentation presents a steep learning curve for many users, particularly those less experienced with Docker or specific V Rising server administration quirks (e.g., port forwarding UDP, understanding `persistentDataPath`, or enabling RCON). To alleviate user frustration and repetitive issues, the documentation needs to be restructured and enriched with practical examples.

## Goals / Non-Goals

**Goals:**
- Provide ready-to-use Docker Compose configurations for common playstyles (Solo, PvE, PvP).
- Clarify data persistence and how it relates to host vs. container paths.
- Explain the process of assigning server admins explicitly and managing player bans.
- Document advanced capabilities like RCON configuration via environment variables, executing RCON commands within temporary Docker containers, and provide a list of useful RCON commands.
- Offer actionable troubleshooting steps for the most common issues (server visibility, save recovery).
- Provide a clear disclaimer and high-level information regarding modding (BepInEx).

**Non-Goals:**
- Modifying the actual Docker image or `start.sh` functionality. This is a pure documentation overhaul.
- Writing extensive guides on how to play the game itself or how to configure complex network infrastructures beyond basic home routing.

## Decisions

- **Scenario-based Recipes:** We will add "Configuration Sets" to `installation.md` to cover Solo/Co-op and PvP servers. This lowers the barrier to entry significantly compared to a single generic example.
- **RCON Environment Variables:** We will emphasize using `HOST_SETTINGS_Rcon__Enabled=true` rather than manual JSON edits, leveraging our existing bash script's capabilities. We will also promote using `gorcon/rcon-cli` via a temporary Docker run to avoid host installations.
- **Data Persistence Visualization:** We will use a simple ASCII diagram in `data-management.md` and/or `configuration.md` to illustrate the relationship between host directories and container volumes.
- **Save Rollbacks:** We will explicitly document the `AutoSaveSmartKeep` folder structure and how to manually revert to an older `AutoSave_Latest` folder in `troubleshooting.md`.

## Risks / Trade-offs

- **Risk:** Maintaining multiple Docker Compose examples in the documentation might lead to outdated examples if default image settings change.
  - **Mitigation:** Keep the examples minimal, focusing only on the specific environment variables that differentiate the playstyles.
- **Risk:** Providing a cron backup script might not apply to Windows hosts using Docker Desktop.
  - **Mitigation:** Clearly label the cron job example as Linux-specific and suggest exploring equivalent scheduled tasks on Windows.
