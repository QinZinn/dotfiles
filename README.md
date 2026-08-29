# dotfiles

Cấu hình Hyprland (Nordic Dark) cho máy CachyOS/Arch.

## Cấu trúc

```
.
├── install.sh
├── home/                    # phản chiếu $HOME
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

## Cài đặt

```bash
cd ~/Projects/dotfiles
./install.sh
```

Script sẽ:
1. Cài packages (pacman + yay).
2. Symlink config vào `$HOME` (file cũ được backup thành `.bak-<timestamp>`).
3. Copy wallpapers vào `~/Pictures/wallpapers`.
4. Áp dụng dark mode (gsettings), cài VSCode Nord theme, set browser mặc định.
5. In các bước cần root (SDDM theme, logind, enable sddm, mask sleep).

Sau đó thực hiện các lệnh root được in ra, rồi logout/login.

## Keybindings

| Phím | Tác vụ |
|---|---|
| `Super` | Rofi launcher |
| `Super + W` | Brave Origin |
| `Super + Q` | Đóng cửa sổ |
| `Super + T` / `Super + Enter` | Alacritty |
| `Super + C` | VSCode |
| `Super + F` | Fullscreen |
| `Super + V` | Clipboard history |
| `Super + N` | Notification center |
| `Super + E` | Thunar |
| `Super + L` | Khóa màn hình |
| `Super + M` | Wlogout |
| `Super + Shift + S` | Screenshot vùng (clipboard) |
| `Super + Shift + W` | Đổi wallpaper |
| `Super + 1..9,0` | Chuyển workspace |
| `Super + Alt + 1..9,0` | Gửi cửa sổ sang workspace |
| `Super + Shift + 1..9,0` | Move window sang workspace |
| `Super + Mouse wheel` | Workspace kế tiếp/trước |

## Phụ thuộc

- Hyprland, Waybar, Rofi, SwayNC, Alacritty, Wlogout
- `awww` (wallpaper backend, thay thế `swww`)
- Grim/Slurp + ffplay (ffmpeg) + ImageMagick (screenshot có freeze)
- wl-clipboard/cliphist
- Thunar + plugins (archive, volman, media-tags, gvfs-mtp, file-roller)
- Nordic GTK/Qt theme, Papirus-Dark icons, JetBrainsMono Nerd Font
- SDDM + Qt5 QML (`qt5-declarative`)
- `gnome-keyring`, `fcitx5` (+ gtk/qt), `brave-origin-bin`, `visual-studio-code-bin` (AUR)
