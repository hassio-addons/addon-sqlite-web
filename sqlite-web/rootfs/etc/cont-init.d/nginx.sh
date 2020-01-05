#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: SQLite Web
# Configures NGINX for use with SQLite Web
# ==============================================================================
declare certfile
declare hassio_dns
declare ingress_entry
declare ingress_interface
declare ingress_port
declare keyfile
declare port

port=$(bashio::addon.port 80)

if bashio::var.has_value "${port}"; then
    bashio::config.require.ssl

    if bashio::config.true 'ssl'; then
        certfile=$(bashio::config 'certfile')
        keyfile=$(bashio::config 'keyfile')

        mv /etc/nginx/servers/direct-ssl.disabled /etc/nginx/servers/direct.conf
        sed -i "s#%%certfile%%#${certfile}#g" /etc/nginx/servers/direct.conf
        sed -i "s#%%keyfile%%#${keyfile}#g" /etc/nginx/servers/direct.conf

    else
        mv /etc/nginx/servers/direct.disabled /etc/nginx/servers/direct.conf
    fi
fi

ingress_entry=$(bashio::addon.ingress_entry)
ingress_interface=$(bashio::addon.ip_address)
ingress_port=$(bashio::addon.ingress_port)
sed -i "s#%%ingress_entry%%#${ingress_entry}#g" /etc/nginx/servers/ingress.conf
sed -i "s/%%interface%%/${ingress_interface}/g" /etc/nginx/servers/ingress.conf
sed -i "s/%%port%%/${ingress_port}/g" /etc/nginx/servers/ingress.conf

if bashio::config.true 'datasette'; then
    port=$(bashio::addon.port 6220)
    if bashio::var.has_value "${port}"; then
        bashio::config.require.ssl

        if bashio::config.true 'ssl'; then
            certfile=$(bashio::config 'certfile')
            keyfile=$(bashio::config 'keyfile')

            mv /etc/nginx/servers/datasette-ssl.disabled \
                /etc/nginx/servers/datasette.conf
            sed -i "s#%%certfile%%#${certfile}#g" /etc/nginx/servers/datasette.conf
            sed -i "s#%%keyfile%%#${keyfile}#g" /etc/nginx/servers/datasette.conf

        else
            mv /etc/nginx/servers/datasette.disabled \
                /etc/nginx/servers/datasette.conf
        fi
    fi
fi

hassio_dns=$(bashio::dns.host)
sed -i "s/%%hassio_dns%%/${hassio_dns}/g" /etc/nginx/includes/resolver.conf
