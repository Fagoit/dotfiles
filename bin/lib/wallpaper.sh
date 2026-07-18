#!/bin/bash
# Shared wallpaper backend logic.
#
# Static images are rendered with hyprpaper (managed as a systemd user
# service). Animated wallpapers (video / gif) are rendered with mpvpaper.
# Only one backend runs at a time; switching backends stops the other.
#
# The selected wallpaper is tracked via the "current/background" symlink.
# A static still frame is kept at "current/background-still" for consumers
# that cannot render video (e.g. hyprlock, and hyprpaper as a fallback).

DOTFILES_DIR="$HOME/.local/share/dotfiles"
CURRENT_BACKGROUND_LINK="$DOTFILES_DIR/current/background"
CURRENT_BACKGROUND_STILL="$DOTFILES_DIR/current/background-still"

# Extensions treated as animated wallpapers (played with mpvpaper).
WALLPAPER_ANIMATED_EXTENSIONS=(mp4 mkv webm mov m4v avi gif)

# mpv options passed through mpvpaper for animated wallpapers.
WALLPAPER_MPV_OPTS="no-audio loop-file=inf panscan=1.0 hwdec=auto"

wallpaper_is_animated() {
  local ext="${1##*.}"
  ext="${ext,,}"
  local e
  for e in "${WALLPAPER_ANIMATED_EXTENSIONS[@]}"; do
    [[ "$ext" == "$e" ]] && return 0
  done
  return 1
}

_wallpaper_stop_animated() {
  pkill -x mpvpaper 2>/dev/null || true
}

_wallpaper_start_animated() {
  local wallpaper="$1"

  if ! command -v mpvpaper &>/dev/null; then
    notify-send "mpvpaper is not installed" "Cannot play animated wallpaper" -t 3000 2>/dev/null || true
    return 1
  fi

  systemctl --user stop hyprpaper.service 2>/dev/null || true
  _wallpaper_stop_animated

  # '*' targets all connected monitors. Detach so callers don't block.
  setsid -f mpvpaper -o "$WALLPAPER_MPV_OPTS" '*' "$wallpaper" >/dev/null 2>&1
}

_wallpaper_start_static() {
  _wallpaper_stop_animated
  systemctl --user restart hyprpaper.service
}

# Refresh the static still frame. For images this is a symlink to the image;
# for videos the first frame is extracted with ffmpeg.
wallpaper_update_still() {
  local wallpaper="$1"

  if wallpaper_is_animated "$wallpaper"; then
    if command -v ffmpeg &>/dev/null; then
      rm -f "$CURRENT_BACKGROUND_STILL"
      ffmpeg -y -i "$wallpaper" -frames:v 1 -f image2 -c:v png \
        "$CURRENT_BACKGROUND_STILL" >/dev/null 2>&1 || true
    fi
  else
    ln -nsf "$wallpaper" "$CURRENT_BACKGROUND_STILL"
  fi
}

# Apply a wallpaper: update symlinks and start the matching backend.
wallpaper_apply() {
  local wallpaper="$1"

  ln -nsf "$wallpaper" "$CURRENT_BACKGROUND_LINK"
  wallpaper_update_still "$wallpaper"

  if wallpaper_is_animated "$wallpaper"; then
    _wallpaper_start_animated "$wallpaper"
  else
    _wallpaper_start_static
  fi
}

# Stop any running wallpaper backend and clear hyprpaper's output.
wallpaper_clear() {
  _wallpaper_stop_animated
  hyprctl hyprpaper wallpaper "," 2>/dev/null || true
}
