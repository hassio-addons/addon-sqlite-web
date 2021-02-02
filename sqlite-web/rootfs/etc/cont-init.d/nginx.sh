#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SQLite Web
# Configures NGINX for use with SQLite Web
# ==============================================================================
declare ingress_entry

ingress_entry=$(bashio::addon.ingress_entry)
sed -i "s#%%ingress_entry%%#${ingress_entry}#g" /etc/nginx/servers/ingress.conf
