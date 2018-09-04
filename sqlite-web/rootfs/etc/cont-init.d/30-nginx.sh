#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: SQLite Web
# Configures NGINX for use with SQLite Web
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare certfile
declare keyfile

# Enable SSL
if hass.config.true 'ssl'; then
    rm /etc/nginx/nginx.conf
    mv /etc/nginx/nginx-ssl.conf /etc/nginx/nginx.conf

    certfile=$(hass.config.get 'certfile')
    keyfile=$(hass.config.get 'keyfile')

    sed -i "s/%%certfile%%/${certfile}/g" /etc/nginx/nginx.conf
    sed -i "s/%%keyfile%%/${keyfile}/g" /etc/nginx/nginx.conf
fi

# Disables IPv6 in case its disabled by the user
if ! hass.config.true 'ipv6'; then
    sed -i '/listen \[::\].*/ d' /etc/nginx/nginx.conf
fi

# Handles the HTTP auth part
if ! hass.config.has_value 'username'; then
    hass.log.warning "Username/password protection is disabled!"
    sed -i '/auth_basic.*/d' /etc/nginx/nginx.conf
else
    username=$(hass.config.get 'username')
    password=$(hass.config.get 'password')
    htpasswd -bc /etc/nginx/.htpasswd "${username}" "${password}"
fi
