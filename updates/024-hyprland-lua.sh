#!/bin/bash
# Migrate ~/.config/hypr from hyprlang (.conf) to the Lua config used by Hyprland 0.55+.
# Old files are kept as *.legacy / *.bak next to the new ones.

DOTFILES_DIR="$HOME/.local/share/dotfiles"
HYPR_DIR="$HOME/.config/hypr"
LEGACY_CONF="$HYPR_DIR/hyprland.conf"

mkdir -p "$HYPR_DIR/conf"

# Hardware profile, derived from the old source= lines when not set yet
if [[ ! -f "$HYPR_DIR/hardware" ]]; then
  profile="desktop"
  if [[ -f "$LEGACY_CONF" ]]; then
    laptop=false
    nvidia=false
    grep -q "laptop-keybindings.conf" "$LEGACY_CONF" && laptop=true
    grep -q "nvidia-env.conf" "$LEGACY_CONF" && nvidia=true
    if $laptop && $nvidia; then
      profile="laptop-nvidia"
    elif $laptop; then
      profile="laptop"
    elif $nvidia; then
      profile="nvidia"
    fi
  fi
  printf '%s\n' "$profile" >"$HYPR_DIR/hardware"
  echo "  - Hardware profile: $profile"
fi

# Monitors: convert monitor= and env= lines, comment out anything else
if [[ ! -f "$HYPR_DIR/conf/monitors.lua" ]]; then
  if [[ -f "$HYPR_DIR/conf/monitors.conf" ]]; then
    awk '
      function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
      /^[ \t]*(#|$)/ { line = $0; sub(/^[ \t]*#/, "--", line); print line; next }
      /^[ \t]*monitor[ \t]*=/ {
        line = $0; sub(/^[ \t]*monitor[ \t]*=/, "", line); sub(/#.*/, "", line)
        n = split(line, f, ",")
        out = trim(f[1]); mode = trim(f[2])
        if (mode == "disable") { print "hl.monitor({ output = \"" out "\", disabled = true })"; next }
        pos = n >= 3 ? trim(f[3]) : "auto"; scale = n >= 4 ? trim(f[4]) : "1"
        if (scale !~ /^[0-9.]+$/) scale = "\"" scale "\""
        print "hl.monitor({ output = \"" out "\", mode = \"" mode "\", position = \"" pos "\", scale = " scale " })"
        if (n > 4) print "-- TODO: extra monitor options not migrated: " line
        next
      }
      /^[ \t]*env[ \t]*=/ {
        line = $0; sub(/^[ \t]*env[ \t]*=/, "", line); sub(/#.*/, "", line)
        i = index(line, ",")
        print "hl.env(\"" trim(substr(line, 1, i - 1)) "\", \"" trim(substr(line, i + 1)) "\")"
        next
      }
      { print "-- TODO: not migrated: " $0 }
    ' "$HYPR_DIR/conf/monitors.conf" >"$HYPR_DIR/conf/monitors.lua"
    mv "$HYPR_DIR/conf/monitors.conf" "$HYPR_DIR/conf/monitors.conf.legacy"
    echo "  - Converted conf/monitors.conf to conf/monitors.lua"
  else
    cp "$DOTFILES_DIR/config/hypr/conf/monitors.lua" "$HYPR_DIR/conf/monitors.lua"
  fi
fi

# Input: start from the repo default; custom input.conf settings must be ported by hand
if [[ ! -f "$HYPR_DIR/conf/input.lua" ]]; then
  cp "$DOTFILES_DIR/config/hypr/conf/input.lua" "$HYPR_DIR/conf/input.lua"
  if [[ -f "$HYPR_DIR/conf/input.conf" ]]; then
    mv "$HYPR_DIR/conf/input.conf" "$HYPR_DIR/conf/input.conf.legacy"
    echo "  - Installed conf/input.lua (check conf/input.conf.legacy for custom settings)"
  fi
fi

# Entrypoint
if [[ ! -f "$HYPR_DIR/hyprland.lua" ]]; then
  cp "$DOTFILES_DIR/config/hypr/hyprland.lua" "$HYPR_DIR/hyprland.lua"
  echo "  - Installed hyprland.lua"
fi
if [[ -f "$LEGACY_CONF" ]]; then
  mv "$LEGACY_CONF" "$LEGACY_CONF.legacy"
  echo "  - Moved hyprland.conf to hyprland.conf.legacy"
fi

# Old "hyprctl dispatch <name> <args>" syntax no longer works with the Lua config
if [[ -f "$HYPR_DIR/hypridle.conf" ]]; then
  cp "$HYPR_DIR/hypridle.conf" "$HYPR_DIR/hypridle.conf.bak"
  sed -i "s|hyprctl dispatch dpms on |hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' |g; s|hyprctl dispatch dpms off |hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })' |g" "$HYPR_DIR/hypridle.conf"
fi
if [[ -f "$HOME/.config/waybar/modules.json" ]]; then
  cp "$HOME/.config/waybar/modules.json" "$HOME/.config/waybar/modules.json.bak"
  sed -i 's|"hyprctl dispatch workspace r-1"|"hyprctl dispatch '"'"'hl.dsp.focus({ workspace = \\"r-1\\" })'"'"'"|; s|"hyprctl dispatch workspace r+1"|"hyprctl dispatch '"'"'hl.dsp.focus({ workspace = \\"r+1\\" })'"'"'"|' "$HOME/.config/waybar/modules.json"
fi
mkdir -p "$HOME/.config/elephant/menus/dynamic"
cp "$DOTFILES_DIR/config/elephant/menus/dynamic/keybindings.lua" "$HOME/.config/elephant/menus/dynamic/keybindings.lua"

# Switching from hyprlang to Lua needs a full reset
if command -v hyprctl &>/dev/null; then
  hyprctl reload full-reset >/dev/null 2>&1 || true
  echo "  - Reloaded Hyprland"
fi
systemctl --user try-restart waybar.service hypridle.service elephant.service 2>/dev/null || true
