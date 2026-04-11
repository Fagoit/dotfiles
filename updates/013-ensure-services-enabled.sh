#!/bin/bash

USER_SERVICES=(
  "elephant.service"
  "mako.service"
  "sunsetr.service"
  "swayosd.service"
  "walker.service"
  "waybar.service"
  "hyprpaper.service"
)

service_to_app() {
  case "$1" in
    swayosd.service) echo "swayosd" ;;
    *) echo "${1%.service}" ;;
  esac
}

app_is_running() {
  case "$1" in
    swayosd) pgrep -x "swayosd-server" >/dev/null 2>&1 ;;
    walker) pgrep -f "walker --gapplication-service" >/dev/null 2>&1 ;;
    *) pgrep -x "$1" >/dev/null 2>&1 ;;
  esac
}

for service in "${USER_SERVICES[@]}"; do
  app="$(service_to_app "$service")"

  if command -v systemctl >/dev/null 2>&1 && [ -d "/run/systemd/system" ]; then
    if systemctl --user is-active --quiet "$service"; then
      echo "  - $service is already active"
    else
      echo "  - Enabling and starting $service..."
      if systemctl --user enable --now "$service" &>/dev/null; then
        echo "    Success: $service enabled and started"
      else
        echo "    Warning: Failed to enable/start $service (may be missing or invalid)"
      fi
    fi
  else
    if app_is_running "$app"; then
      echo "  - $app is already active"
    else
      echo "  - Starting $app (OpenRC/non-systemd fallback)..."
      if restart-app "$app" &>/dev/null; then
        echo "    Success: $app started"
      else
        echo "    Warning: Failed to start $app"
      fi
    fi
  fi
done

# Enable hypridle only on laptops
if ls /sys/class/power_supply/BAT* >/dev/null 2>&1 || [ -d /sys/class/power_supply/battery ]; then
  if command -v systemctl >/dev/null 2>&1 && [ -d "/run/systemd/system" ]; then
    if systemctl --user is-active --quiet "hypridle.service"; then
      echo "  - hypridle.service is already active"
    else
      echo "  - Enabling and starting hypridle.service (laptop detected)..."
      if systemctl --user enable --now "hypridle.service" &>/dev/null; then
        echo "    Success: hypridle.service enabled and started"
      else
        echo "    Warning: Failed to enable/start hypridle.service"
      fi
    fi
  else
    if pgrep -x "hypridle" >/dev/null 2>&1; then
      echo "  - hypridle is already active"
    else
      echo "  - Starting hypridle (laptop detected, OpenRC/non-systemd fallback)..."
      if restart-app "hypridle" &>/dev/null; then
        echo "    Success: hypridle started"
      else
        echo "    Warning: Failed to start hypridle"
      fi
    fi
  fi
fi