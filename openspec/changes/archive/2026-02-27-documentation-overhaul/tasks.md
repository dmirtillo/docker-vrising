## 1. Installation Documentation Updates

- [x] 1.1 Add a "Configuration Sets (Recipes)" section to `docs/installation.md`
- [x] 1.2 Add the "Standard PvE with Friends" Docker Compose recipe
- [x] 1.3 Add the "Standard PvP" Docker Compose recipe
- [x] 1.4 Update the Quick Start guide to reference the new configuration sets

## 2. Configuration & Data Management Updates

- [x] 2.1 Add an ASCII diagram explaining host vs container data volumes to `docs/configuration.md`
- [x] 2.2 Add instructions for configuring Server Admins via `adminlist.txt` and bans via `banlist.txt` in `docs/configuration.md`
- [x] 2.3 Add examples of enabling RCON via environment variables (`HOST_SETTINGS_Rcon__`) in `docs/configuration.md`
- [x] 2.4 Add instructions for executing RCON commands via a temporary gorcon Docker container and provide a list of useful commands in `docs/configuration.md`
- [x] 2.5 Add an automated backup script example using `cron` to `docs/data-management.md`

## 3. Troubleshooting Guide Enhancements

- [x] 3.1 Add a "Server Not Showing in the Public List" section to `docs/troubleshooting.md` with port forwarding and firewall checks
- [x] 3.2 Add a "Save Corruption & Rollbacks" section to `docs/troubleshooting.md` detailing the `AutoSaveSmartKeep` recovery process
- [x] 3.3 Add a "Modding Support" section with information on BepInEx installation methodology and vanilla image disclaimers to `docs/troubleshooting.md`
