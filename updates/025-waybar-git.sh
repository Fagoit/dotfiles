#!/bin/bash
# Waybar 0.15.0 sends legacy "dispatch workspace N" over IPC, which Hyprland's Lua
# config rejects, so clicking workspaces does nothing. waybar-git has the fix.

if pacman -Qq waybar-git &>/dev/null; then
  echo "  - waybar-git already installed"
  exit 0
fi

echo "  - Replacing waybar with waybar-git (fixes workspace clicks under Lua config)"
yay -S --needed waybar-git || exit 1
systemctl --user try-restart waybar.service 2>/dev/null || true
