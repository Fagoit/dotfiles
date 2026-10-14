#!/bin/bash
# Revert UI fonts from Terminus back to CaskaydiaMono Nerd Font.

DOTFILES_DIR="$HOME/.local/share/dotfiles"

rm -f "$HOME/.config/fontconfig/fonts.conf"
fc-cache -f >/dev/null 2>&1 || true
echo "  - Removed Terminus fontconfig"

cp "$DOTFILES_DIR/config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
cp "$DOTFILES_DIR/config/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
cp "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
cp "$DOTFILES_DIR/config/swayosd/style.css" "$HOME/.config/swayosd/style.css"
cp "$DOTFILES_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"

if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.interface font-name 'CaskaydiaMono Nerd Font Mono 11'
  gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font Mono 11'
  echo "  - gsettings fonts -> CaskaydiaMono Nerd Font Mono 11"
fi

bash "$DOTFILES_DIR/updates/020-waybar-themes.sh"

# Restore the currently active waybar style from the matching theme if possible.
if grep -q '"height": 32' "$HOME/.config/waybar/config" 2>/dev/null; then
  cp "$DOTFILES_DIR/config/waybar/themes/glass/style.css" "$HOME/.config/waybar/style.css"
  cp "$DOTFILES_DIR/config/waybar/themes/glass/config" "$HOME/.config/waybar/config"
else
  cp "$DOTFILES_DIR/config/waybar/style.css" "$HOME/.config/waybar/style.css"
fi

killall -SIGUSR2 ghostty 2>/dev/null || true
systemctl --user try-restart waybar.service 2>/dev/null || true
systemctl --user try-restart swayosd.service 2>/dev/null || true
