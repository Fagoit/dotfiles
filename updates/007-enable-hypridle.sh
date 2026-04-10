#!/bin/bash

# Only enable hypridle on laptops
if ! ls /sys/class/power_supply/BAT* >/dev/null 2>&1 && [ ! -d /sys/class/power_supply/battery ]; then
  echo "  - Desktop detected, skipping hypridle"
  exit 0
fi

SERVICE="hypridle.service"

if systemctl --user is-active --quiet "$SERVICE" 2>/dev/null; then
  echo "  - $SERVICE already running, skipping"
  exit 0
fi

if systemctl --user enable --now "$SERVICE" &>/dev/null; then
  echo "  - $SERVICE enabled and started"
else
  echo "  - $SERVICE failed to enable/start"
fi
