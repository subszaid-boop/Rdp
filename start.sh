#!/bin/bash
set -e

mkdir -p /var/run/dbus
dbus-daemon --system --fork

/usr/sbin/sshd

/usr/sbin/xrdp-sesman &

exec /usr/sbin/xrdp --nodaemon
