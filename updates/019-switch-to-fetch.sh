#!/bin/bash
# Swap the terminal greeting from fastfetch to fetch (areofyl/fetch).

DOTFILES_DIR="$HOME/.local/share/dotfiles"

if command -v yay &>/dev/null; then
  AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
  AUR_HELPER="paru"
else
  AUR_HELPER=""
fi

if ! pacman -Qq fetch-git &>/dev/null && ! pacman -Qq fetch &>/dev/null; then
  echo "  - Installing fetch-git..."
  if [ -n "$AUR_HELPER" ]; then
    "$AUR_HELPER" -S fetch-git --noconfirm 2>/dev/null || true
  fi
else
  echo "  - fetch already installed"
fi

if pacman -Qq fastfetch &>/dev/null; then
  echo "  - Removing fastfetch..."
  sudo pacman -Rns fastfetch --noconfirm 2>/dev/null || true
fi

rm -rf "$HOME/.config/fastfetch"
rm -rf "$HOME/.config/fetch"
ln -snf "$DOTFILES_DIR/config/fetch" "$HOME/.config/fetch"
echo "  - Linked fetch config"

if [[ -f "$DOTFILES_DIR/config/elephant/menus/themes.lua" ]]; then
  mkdir -p "$HOME/.config/elephant/menus"
  cp "$DOTFILES_DIR/config/elephant/menus/themes.lua" "$HOME/.config/elephant/menus/themes.lua"
  echo "  - Updated themes menu"
fi

rm -f "$HOME/.config/elephant/menus/dynamic/fastfetch-themes.lua"

if [[ -f "$HOME/.config/walker/config.toml" ]]; then
  sed -i '/menus:fastfetch_themes/d' "$HOME/.config/walker/config.toml"
  echo "  - Removed fastfetch from Walker"
fi

# Elephant keeps menus in memory until restart.
if systemctl --user restart elephant.service 2>/dev/null; then
  echo "  - Restarted elephant"
fi
if systemctl --user restart walker.service 2>/dev/null; then
  echo "  - Restarted walker"
fi
