#!/bin/bash
# Install the extra Waybar layouts (hyprdots, peony, sleek, island,
# westwing, glass, taskbar) and refresh shared modules.

DOTFILES_DIR="$HOME/.local/share/dotfiles"
SRC="$DOTFILES_DIR/config/waybar"
DST="$HOME/.config/waybar"

mkdir -p "$DST/themes"

if [[ -f "$SRC/modules.json" ]]; then
  cp "$SRC/modules.json" "$DST/modules.json"
  echo "  - Updated waybar modules.json"
fi

for theme in hyprdots peony sleek island westwing glass taskbar modern; do
  if [[ -d "$SRC/themes/$theme" ]]; then
    mkdir -p "$DST/themes/$theme"
    cp -f "$SRC/themes/$theme/"* "$DST/themes/$theme/"
    echo "  - Installed waybar theme: $theme"
  fi
done
