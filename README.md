# dotfiles

Nordic Dark Hyprland configuration for Arch/CachyOS.

![Preview](preview.png)

## Structure

```
.
├── install.sh
├── home/                    # mirrors $HOME
│   ├── .config/
│   │   ├── hypr/            # hyprland.lua, hypridle.conf, hyprlock.conf
│   │   ├── waybar/
│   │   ├── rofi/
│   │   ├── alacritty/
│   │   ├── swaync/
│   │   ├── gtk-3.0/  gtk-4.0/
│   │   ├── qt5ct/  qt6ct/  Kvantum/
│   │   ├── wlogout/
│   │   ├── Code/User/       # VSCode settings
│   │   ├── sddm.conf.d/
│   │   ├── sddm/themes/Nordic/
│   │   ├── systemd/logind.conf.d/
│   │   └── mimeapps.list
│   └── .local/bin/          # hypr-wallpaper, hypr-clipboard, hypr-screenshot
└── wallpapers/
```

## Install

```bash
cd ~/Projects/dotfiles
./setup
```

The script will:
1. Install base packages (pacman).
2. Symlink configs into `$HOME` (existing files are backed up as `.bak-<timestamp>`).
3. Copy wallpapers into `~/Pictures/wallpapers`.
4. Apply dark mode (gsettings), set the default browser.
5. Print the root steps that must be run manually (SDDM theme, logind, enable sddm, mask sleep).

Run the printed root commands, then log out and back in.

### Optional themed apps

Themed apps are optional and installed on demand:

```bash
./setup install brave               # Brave Origin + default browser
./setup install vscode              # VSCode + Nord extension
./setup install steam               # Millennium + Material-Theme + Nord palette
./setup install spotify             # Spicetify + Nordic theme + apply
./setup install vesktop             # Vesktop (theme is in the config)
./setup install opencode            # OpenCode Nord theme (no package needed)
./setup install all                 # everything above
```

Available apps: `brave`, `vscode`, `steam`, `spotify`, `vesktop`, `opencode`, `all`. Run `./setup help` for usage.

### Wallpaper slideshow toggle

A Waybar module (`󰔎`/`󰑘`) toggles between a static wallpaper and a slideshow (random wallpaper every 10 min via `waypaper --random`). Click it to toggle; the state persists across logins.

## Keybindings

| Key | Action |
|---|---|
| `Super` | Rofi launcher |
| `Super + W` | Brave Origin |
| `Super + Q` | Close window |
| `Super + T` / `Super + Enter` | Alacritty |
| `Super + C` | VSCode |
| `Super + F` | Fullscreen |
| `Super + V` | Clipboard history |
| `Super + N` | Notification center |
| `Super + E` | Thunar |
| `Super + L` | Lock screen |
| `Super + M` | Wlogout |
| `Super + Shift + S` | Screenshot region (clipboard) |
| `Super + Shift + W` | Change wallpaper (random) |
| `Super + Shift + G` | Pick wallpaper (waypaper) |
| `Super + 1..9,0` | Switch workspace |
| `Super + Alt + 1..9,0` | Move window to workspace |
| `Super + Shift + 1..9,0` | Move window to workspace |
| `Super + Left/Right` | Previous/next workspace |
| `Super + Mouse wheel` | Next/previous workspace |

## App theming

Nordic themes are included for Spotify (Spicetify), Steam (Millennium), OpenCode and Vesktop.

### OpenCode

Theme lives at `~/.config/opencode/themes/nordic.json`, activated via `~/.config/opencode/tui.json`:

```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "nordic"
}
```

### Vesktop (Discord)

Theme lives at `~/.config/vesktop/themes/nordic.theme.css` (system24 base + Nord palette). Enable it in **Settings → Vencord → Themes → Nordic**.

### Spotify (Spicetify)

### Spotify (Spicetify)

Theme lives at `~/.config/spicetify/Themes/Nordic/` (Sleek base CSS + Nord `--spice-*` palette).

```bash
sudo chown -R "$USER":"$USER" /opt/spotify   # only once, so spicetify can patch
sudo pacman -S --needed spicetify-cli        # or spicetify-bin
spicetify config current_theme Nordic
spicetify config color_scheme base
spicetify backup apply
```

Restart Spotify. `spicetify restore` undoes it.

### Steam (Millennium)

Uses the [Material-Theme](https://github.com/kuska1/Material-Theme) base with a Nord `matugen.css` palette.

1. Install Millennium: `yay -S millennium` (or `millennium-bin`).
2. Install the theme base:
   ```bash
   git clone --depth=1 https://github.com/kuska1/Material-Theme.git \
     ~/.steam/steam/millennium/themes/Material-Theme
   ```
3. Apply the Nord palette (from this repo):
   ```bash
   cp "$HOME/.config/millennium/nordic-matugen.css" \
     ~/.steam/steam/millennium/themes/Material-Theme/css/main/colors/matugen.css
   ```
4. `~/.config/millennium/config.json` already selects `Material-Theme` with `Color=Matugen`, `Appearance=Dark`.
5. Restart Steam.

## Dependencies

- Hyprland, Waybar, Rofi, SwayNC, Alacritty, Wlogout
- `awww` (wallpaper backend, replaces `swww`)
- Grim/Slurp + ffplay (ffmpeg) + ImageMagick (frozen-region screenshots)
- wl-clipboard/cliphist
- Thunar + plugins (archive, volman, media-tags, gvfs-mtp, file-roller)
- Nordic GTK/Qt theme, Papirus-Dark icons, JetBrainsMono Nerd Font
- SDDM + Qt5 QML (`qt5-declarative`)
- `gnome-keyring`, `fcitx5` (+ gtk/qt), `brave-origin-bin`, `visual-studio-code-bin` (AUR)
- Optional theming: `spicetify-cli` (Spotify), `millennium` (Steam)
