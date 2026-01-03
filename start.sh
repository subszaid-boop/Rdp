#!/bin/bash
set -e

export USER=admin
export HOME=/home/admin
export DISPLAY=:1

# DBus
mkdir -p /var/run/dbus
dbus-daemon --system --fork

# Start VNC
su - admin -c "vncserver :1 -geometry 1280x720"

# Start noVNC web
websockify --web /usr/share/novnc/ 8080 localhost:5901
