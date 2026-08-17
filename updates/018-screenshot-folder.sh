#!/bin/bash
# Persist screenshots to ~/Pictures/Screenshots (save + clipboard) instead of
# clipboard-only, and point the Walker screenshot menu at that folder.

DOTFILES_DIR="$HOME/.local/share/dotfiles"
SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
MENU_SRC="$DOTFILES_DIR/config/elephant/menus/screenshots.lua"
MENU_DST="$HOME/.config/elephant/menus/screenshots.lua"

mkdir -p "$SCREENSHOTS_DIR"
echo "  - Ensured $SCREENSHOTS_DIR exists"

if [[ -f "$MENU_SRC" ]]; then
  mkdir -p "$(dirname "$MENU_DST")"
  cp "$MENU_SRC" "$MENU_DST"
  echo "  - Updated elephant screenshots menu"
fi

# Keybinds are sourced from default/hypr; reload so Super+Shift+S picks them up.
if command -v hyprctl &>/dev/null; then
  hyprctl reload >/dev/null 2>&1 || true
  echo "  - Reloaded Hyprland"
fi
