#!/bin/bash
set -e

echo "[+] Starting services..."

# DBus
mkdir -p /var/run/dbus
dbus-daemon --system --fork
echo "[✓] DBus started"

# SSH
service ssh start
echo "[✓] SSH started"

# X11 socket directory
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# XRDP needs sesman
service xrdp-sesman start
echo "[✓] XRDP sesman started"

# Start XRDP in foreground (Docker safe)
echo "[✓] XRDP started"
exec /usr/sbin/xrdp --nodaemon
