#!/bin/bash
# Trim boot and idle overhead: socket-activate docker, drop boot blockers,
# idle-prioritise plocate, tune swap for zram, cap the journal, and mask the
# background indexers that run without being asked.

set -e

log() { echo "  - $*"; }

# Boot blockers
sudo systemctl disable NetworkManager-wait-online.service 2>/dev/null || true
log "NetworkManager-wait-online disabled"

sudo systemctl disable systemd-networkd-wait-online.service 2>/dev/null || true

# Docker: socket activation instead of boot-time start
if command -v docker &>/dev/null; then
  sudo systemctl disable docker.service 2>/dev/null || true
  sudo systemctl enable docker.socket 2>/dev/null || true
  log "docker switched to socket activation"
fi

# TPM NvPCR units fail on every boot; /home unlocks from a key file
for unit in systemd-pcrproduct.service systemd-tpm2-setup-early.service systemd-pcrlogin@.service; do
  sudo systemctl mask "$unit" 2>/dev/null || true
done
log "TPM NvPCR units masked"

# plocate rebuilds daily and burns seconds of CPU mid-session
if command -v plocate &>/dev/null; then
  sudo mkdir -p /etc/systemd/system/plocate-updatedb.service.d
  sudo tee /etc/systemd/system/plocate-updatedb.service.d/limits.conf >/dev/null <<'EOF'
[Service]
Nice=19
IOSchedulingClass=idle
CPUSchedulingPolicy=idle
EOF
  log "plocate-updatedb set to idle priority"
fi

# zram is compressed RAM; swap into it early rather than thrashing later
if [ -e /dev/zram0 ]; then
  sudo tee /etc/sysctl.d/99-zram.conf >/dev/null <<'EOF'
vm.swappiness = 150
vm.page-cluster = 0
EOF
  sudo sysctl -p /etc/sysctl.d/99-zram.conf >/dev/null
  log "swappiness=150, page-cluster=0"
fi

# Journal cap
sudo mkdir -p /etc/systemd/journald.conf.d
sudo tee /etc/systemd/journald.conf.d/size.conf >/dev/null <<'EOF'
[Journal]
SystemMaxUse=200M
SystemMaxFileSize=50M
RuntimeMaxUse=50M
EOF
sudo systemctl restart systemd-journald 2>/dev/null || true
sudo journalctl --vacuum-size=200M >/dev/null 2>&1 || true
log "journald capped at 200M"

# User-level: on-demand accessibility bus, no background indexers
mkdir -p "$HOME/.config/environment.d"
cat > "$HOME/.config/environment.d/no-at-bridge.conf" <<'EOF'
# Spawn at-spi's accessibility bus on demand rather than at every session start.
NO_AT_BRIDGE=1
EOF
log "at-spi set to on-demand"

for service in localsearch-3.service gvfs-daemon.service gvfs-metadata.service; do
  systemctl --user mask "$service" &>/dev/null || true
done
log "background indexers and gvfs daemons masked"

sudo systemctl daemon-reload

echo "  - Reboot to apply boot-time changes"
