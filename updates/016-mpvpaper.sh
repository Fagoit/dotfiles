#!/bin/bash
# Add animated wallpaper support: install mpvpaper and seed the lock-screen
# still frame for the currently selected wallpaper.

DOTFILES_DIR="$HOME/.local/share/dotfiles"

if command -v yay &>/dev/null; then
  AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
  AUR_HELPER="paru"
else
  AUR_HELPER=""
fi

if ! pacman -Qq mpvpaper &>/dev/null; then
  echo "  - Installing mpvpaper..."
  if [ -n "$AUR_HELPER" ]; then
    "$AUR_HELPER" -S mpvpaper --noconfirm 2>/dev/null || true
  else
    sudo pacman -S mpvpaper --noconfirm 2>/dev/null || true
  fi
else
  echo "  - mpvpaper already installed"
fi

# Seed the still frame used by hyprlock (and hyprpaper) for the current
# wallpaper so existing installs don't show a blank lock screen.
if [ -e "$DOTFILES_DIR/current/background" ]; then
  source "$DOTFILES_DIR/bin/lib/wallpaper.sh"
  target=$(readlink -f "$DOTFILES_DIR/current/background")
  if [ -n "$target" ] && [ -e "$target" ]; then
    wallpaper_update_still "$target"
    echo "  - Generated lock-screen still frame"
  fi
fi
