#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SQLite Web
# Configures NGINX for use with SQLite Web
# ==============================================================================

# Generate Ingress configuration
bashio::var.json \
    entry "$(bashio::addon.ingress_entry)" \
    | tempio \
        -template /etc/nginx/templates/ingress.gtpl \
        -out /etc/nginx/servers/ingress.conf
