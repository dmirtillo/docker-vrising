# Server Configuration

The V Rising Docker image provides three ways to configure your server: environment variables, dynamic JSON patching, and direct file editing.

## 1. Core Environment Variables

These variables control the basic identity and networking of your server.

| Variable | Default | Description |
| :--- | :--- | :--- |
| `TZ` | `Europe/Brussels` | Timezone for the server logs and scheduling. |
| `SERVERNAME` | `trueosiris-V` | The name of your server as it appears in the server list. |
| `WORLDNAME` | `world1` | The name of the world save file. |
| `GAMEPORT` | `9876` | The UDP port for game traffic. |
| `QUERYPORT` | `9877` | The UDP port for Steam query traffic. |
| `LOGDAYS` | `30` | Number of days to keep server logs before automatic cleanup. |
| `BRANCH` | `(latest)` | Optional: Use `legacy-1.0.x-pc` to run an older version. |

## 2. Dynamic JSON Configuration (Recommended)

You can modify almost any setting in `ServerGameSettings.json` and `ServerHostSettings.json` directly from your `docker-compose.yml` or Docker CLI using environment variable prefixes.

### Basic Usage
- Use `GAME_SETTINGS_` to patch `ServerGameSettings.json`
- Use `HOST_SETTINGS_` to patch `ServerHostSettings.json`

Example:
```yaml
environment:
  - HOST_SETTINGS_ListOnSteam=true
  - HOST_SETTINGS_ListOnEOS=true
  - GAME_SETTINGS_GameModeType=PvE
```

### Nested Parameters
V Rising settings are often nested. Use a double underscore (`__`) to navigate through JSON levels.

Example:
```yaml
environment:
  - HOST_SETTINGS_Rcon__Enabled=true
  - HOST_SETTINGS_Rcon__Password=mypassword
  - GAME_SETTINGS_UnitStatModifiers_Global__MaxHealthModifier=2
  - GAME_SETTINGS_CastleStatModifiers_Global__HeartLimits__Level1__FloorLimit=100
```

### Features
- **Case-Insensitive**: Both `HOST_SETTINGS_ListOnSteam` and `HOST_SETTINGS_LISTONSTEAM` work.
- **Fail-Safe**: If you provide a setting that doesn't exist, it will be ignored.
- **Type Validation**: If a setting expects a number and you provide a string, the update will be skipped to prevent corruption.

## 3. Direct File Editing

You can also edit the JSON files directly on your host machine. They are located in your persistent data directory:
- `/mnt/vrising/persistentdata/Settings/ServerGameSettings.json`
- `/mnt/vrising/persistentdata/Settings/ServerHostSettings.json`

**Priority of Settings:**
1. Dynamic Environment Variables (`GAME_SETTINGS_*`)
2. Local files in `/persistentdata`
3. Default files in `/server` (reset on every Steam update)

## RCON (Optional)

To enable RCON, you can use the dynamic settings above or manually add the following block to your `ServerHostSettings.json`:

```json
"Rcon": {
  "Enabled": true,
  "Password": "docker",
  "Port": 25575
}
```

To communicate using the RCON protocol, we recommend using the [RCON CLI](https://github.com/gorcon/rcon-cli) by gorcon.
