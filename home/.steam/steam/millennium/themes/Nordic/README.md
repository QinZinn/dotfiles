# Nordic (Millennium / Steam)

Nordic Dark theme for Steam, matching the dotfiles color scheme.

## Install

1. Install the [Millennium Patcher](https://steambrew.app/) for Steam.
2. Put this theme folder in your Millennium themes directory:
   ```bash
   cp -r "$HOME/.steam/steam/millennium/themes/Nordic" ~/.steam/steam/millennium/themes/
   ```
   (The repo path is `~/.steam/steam/millennium/themes/Nordic/`, so with the dotfiles install.sh it is already symlinked there.)
3. Launch Steam, open **Steam → Millennium**, go to **Themes**, select **Nordic**, and restart Steam.

## Files

- `skin.json` — theme manifest
- `webkit.css` — entry point, imports `css/main/main.css`
- `css/main/main.css` — Nordic palette + Steam overrides

The palette uses the standard Nord colors:

| Token | Value |
|---|---|
| `--background` | `#2E3440` |
| `--panel-background` | `#3B4252` |
| `--text` | `#D8DEE9` |
| `--accent` | `#88C0D0` |
