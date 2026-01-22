FROM grafana/grafana:11.4.0

# Copy provisioning configuration
COPY provisioning /etc/grafana/provisioning

# Copy pre-built dashboards
COPY dashboards /var/lib/grafana/dashboards

# Environment variables for Render
ENV GF_PATHS_DATA=/var/data/grafana
ENV GF_PATHS_PLUGINS=/var/data/grafana/plugins
ENV GF_SERVER_HTTP_PORT=3000

# Security settings
ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_AUTH_ANONYMOUS_ENABLED=false
ENV GF_USERS_ALLOW_SIGN_UP=false

# Fix permissions for Render's disk mount
# Render mounts disks as root, but Grafana runs as uid 472
USER root
RUN mkdir -p /var/data/grafana/plugins && \
    chown -R grafana:root /var/data && \
    chmod -R 775 /var/data
USER grafana

# Expose Grafana port
EXPOSE 3000
