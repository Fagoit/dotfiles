#!/bin/bash
# Replace the stale kora-pgrey GTK icon theme (not installed) with the theme's
# Papirus-Dark setting so app icons like Telegram render correctly.

DOTFILES_DIR="$HOME/.local/share/dotfiles"
ICON_THEME="Papirus-Dark"

if [[ -f "$DOTFILES_DIR/current/theme/icons.theme" ]]; then
  ICON_THEME="$(<"$DOTFILES_DIR/current/theme/icons.theme")"
fi

for gtk_settings in "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"; do
  if [[ -f "$gtk_settings" ]]; then
    sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$ICON_THEME/" "$gtk_settings"
    echo "  - Updated $(basename "$(dirname "$gtk_settings")")/settings.ini -> $ICON_THEME"
  fi
done

# Keep the tracked defaults in sync for future update-configs runs.
for gtk_settings in "$DOTFILES_DIR/config/gtk-3.0/settings.ini" "$DOTFILES_DIR/config/gtk-4.0/settings.ini"; do
  if [[ -f "$gtk_settings" ]]; then
    sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$ICON_THEME/" "$gtk_settings"
  fi
done

if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
  echo "  - gsettings icon-theme -> $ICON_THEME"
fi
