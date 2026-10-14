#!/bin/bash
# Switch the system UI font to bitmap Terminus at 12px.

DOTFILES_DIR="$HOME/.local/share/dotfiles"

if command -v yay &>/dev/null; then
  AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
  AUR_HELPER="paru"
else
  AUR_HELPER=""
fi

install_pkg() {
  local pkg="$1"
  if pacman -Qq "$pkg" &>/dev/null; then
    echo "  - $pkg already installed"
    return
  fi
  echo "  - Installing $pkg..."
  if [ -n "$AUR_HELPER" ]; then
    "$AUR_HELPER" -S "$pkg" --noconfirm 2>/dev/null || sudo pacman -S "$pkg" --noconfirm --needed 2>/dev/null || true
  else
    sudo pacman -S "$pkg" --noconfirm --needed 2>/dev/null || true
  fi
}

install_pkg terminus-font
install_pkg ttf-terminus-nerd

mkdir -p "$HOME/.config/fontconfig"
cp "$DOTFILES_DIR/config/fontconfig/fonts.conf" "$HOME/.config/fontconfig/fonts.conf"
fc-cache -f >/dev/null 2>&1 || true
echo "  - Installed fontconfig (bitmap Terminus, no AA)"

for gtk_settings in "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"; do
  if [[ -f "$gtk_settings" ]]; then
    sed -i 's/^gtk-font-name=.*/gtk-font-name=Terminus 12/' "$gtk_settings"
  fi
done

if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.interface font-name 'Terminus 12'
  gsettings set org.gnome.desktop.interface monospace-font-name 'Terminus 12'
  echo "  - gsettings fonts -> Terminus 12"
fi

if [[ -f "$DOTFILES_DIR/config/ghostty/config" ]]; then
  cp "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
fi

if [[ -f "$DOTFILES_DIR/config/swayosd/style.css" ]]; then
  cp "$DOTFILES_DIR/config/swayosd/style.css" "$HOME/.config/swayosd/style.css"
fi

if [[ -f "$DOTFILES_DIR/config/hypr/hyprlock.conf" ]]; then
  cp "$DOTFILES_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
fi

# Keep the active waybar style and all theme presets on Terminus 12.
if [[ -f "$HOME/.config/waybar/style.css" ]]; then
  sed -i 's/font-family: CaskaydiaMono Nerd Font;/font-family: Terminus, "Terminess Nerd Font", "CaskaydiaMono Nerd Font";/' "$HOME/.config/waybar/style.css"
  sed -i 's/font-size: 1[0-9]px;/font-size: 12px;/' "$HOME/.config/waybar/style.css"
fi
if [[ -d "$DOTFILES_DIR/config/waybar/themes" ]]; then
  bash "$DOTFILES_DIR/updates/020-waybar-themes.sh"
fi

killall -SIGUSR2 ghostty 2>/dev/null || true
systemctl --user try-restart waybar.service 2>/dev/null || true
systemctl --user try-restart swayosd.service 2>/dev/null || true
