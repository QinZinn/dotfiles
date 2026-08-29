#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$DOTFILES_DIR/home"

# ------------------------------------------------------------------
# 1. Install packages (official repo + AUR via yay)
# ------------------------------------------------------------------
echo "==> Installing packages"
sudo pacman -S --needed \
  hyprland hypridle hyprlock waybar rofi swaync xdg-desktop-portal-hyprland \
  awww grim slurp wl-clipboard cliphist brightnessctl playerctl \
  network-manager-applet blueman polkit-kde-agent wlogout \
  thunar gvfs tumbler thunar-archive-plugin thunar-volman thunar-media-tags-plugin gvfs-mtp file-roller \
  qt5-wayland qt6-wayland qt5ct qt6ct kvantum kvantum-qt5 \
  ffmpeg imagemagick \
  nordic-theme-git kvantum-theme-nordic-git papirus-icon-theme otf-font-awesome \
  ttf-jetbrains-mono-nerd noto-fonts \
  sddm qt5-declarative gnome-keyring \
  fcitx5 fcitx5-gtk fcitx5-qt \
  brave-origin-bin

if command -v yay >/dev/null 2>&1; then
  yay -S --needed visual-studio-code-bin || true
fi

# ------------------------------------------------------------------
# 2. Symlink all configs under home/ into $HOME (with backup)
# ------------------------------------------------------------------
link_file() {
  local src="$1" dst="$2"
  if [[ ! -e "$src" ]]; then
    echo "SKIP (missing): $src"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    local bak="$dst.bak-$(date +%Y%m%d-%H%M%S)"
    echo "Backup: $dst -> $bak"
    mv "$dst" "$bak"
  fi
  ln -sfn "$src" "$dst"
}

echo "==> Creating symlinks"
while IFS= read -r file; do
  rel="${file#"$HOME_DIR"/}"
  link_file "$file" "$HOME/$rel"
done < <(find "$HOME_DIR" -type f | sort)

chmod +x "$HOME/.local/bin"/hypr-* 2>/dev/null || true

# ------------------------------------------------------------------
# 3. Wallpapers
# ------------------------------------------------------------------
if [[ -d "$DOTFILES_DIR/wallpapers" ]]; then
  mkdir -p "$HOME/Pictures/wallpapers"
  cp -n "$DOTFILES_DIR"/wallpapers/* "$HOME/Pictures/wallpapers/"
  echo "==> Wallpapers copied"
fi

# ------------------------------------------------------------------
# 4. Dark mode / GTK settings via gsettings
# ------------------------------------------------------------------
if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface color-scheme prefer-dark || true
  gsettings set org.gnome.desktop.interface gtk-theme Nordic || true
  gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark || true
  gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 13' || true
fi

# ------------------------------------------------------------------
# 5. VSCode extension + default browser
# ------------------------------------------------------------------
if command -v code >/dev/null 2>&1; then
  code --install-extension arcticicestudio.nord-visual-studio-code --force || true
fi
xdg-settings set default-web-browser brave-origin.desktop || true

# ------------------------------------------------------------------
# 6. Root steps the user must run manually
# ------------------------------------------------------------------
cat <<'EOF'

==> Các bước cần root (chạy thủ công, vì cần quyền root):
  # SDDM theme
  sudo mkdir -p /usr/share/sddm/themes/Nordic
  sudo cp -r "$HOME/.config/sddm/themes/Nordic/." /usr/share/sddm/themes/Nordic/
  # SDDM config + logind no-sleep
  sudo install -Dm644 "$HOME/.config/sddm.conf.d/10-nordic.conf" /etc/sddm.conf.d/10-nordic.conf
  sudo install -Dm644 "$HOME/.config/systemd/logind.conf.d/90-no-sleep.conf" /etc/systemd/logind.conf.d/90-no-sleep.conf
  # Services
  sudo systemctl enable sddm
  sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
  sudo systemctl reload systemd-logind

==> Sau đó logout/login (hoặc reboot) để áp dụng.
EOF

echo "==> Done."
