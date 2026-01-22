#!/bin/bash
# Custom entrypoint for Grafana on Render
# Fixes permissions on the mounted disk before starting Grafana

set -e

# Create data directories and fix permissions
# This runs at startup AFTER Render mounts the disk
mkdir -p /var/data/grafana/plugins
chown -R grafana:root /var/data/grafana
chmod -R 775 /var/data/grafana

# Switch to grafana user and run the original entrypoint
exec gosu grafana /run.sh "$@"
