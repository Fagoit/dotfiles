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

for service in "${USER_SERVICES[@]}"; do
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
done

# Enable hypridle only on laptops
if ls /sys/class/power_supply/BAT* >/dev/null 2>&1 || [ -d /sys/class/power_supply/battery ]; then
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
fi