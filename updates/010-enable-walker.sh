#!/bin/bash

SERVICE="walker.service"
APP="${SERVICE%.service}"

if command -v systemctl >/dev/null 2>&1 && [ -d "/run/systemd/system" ]; then
  if systemctl --user is-active --quiet "$SERVICE" 2>/dev/null; then
    echo "  - $SERVICE already running, skipping"
    exit 0
  fi

  if systemctl --user enable --now "$SERVICE" &>/dev/null; then
    echo "  - $SERVICE enabled and started"
  else
    echo "  - $SERVICE failed to enable/start"
  fi
  exit 0
fi

if pgrep -f "walker --gapplication-service" >/dev/null 2>&1; then
  echo "  - $APP already running, skipping"
else
  if restart-app "$APP" >/dev/null 2>&1; then
    echo "  - $APP started (OpenRC/non-systemd fallback)"
  else
    echo "  - $APP failed to start"
  fi
fi
