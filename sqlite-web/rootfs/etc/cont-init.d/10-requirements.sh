#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: SQLite Web
# This files check if all user configuration requirements are met
# ==============================================================================

# Require username / password
if ! bashio::config.true 'leave_front_door_open'; then
    bashio::config.require.username 'username';
    bashio::config.require.password 'password';
fi

# Require a secure password
if bashio::config.has_value 'password' \
    && ! bashio::config.true 'i_like_to_be_pwned'; then
    bashio::config.require.safe_password 'password'
fi

# Check SSL cerrificate
bashio::config.require.ssl 'ssl' 'certfile' 'keyfile'

# Check if database file exist
if ! bashio::fs.file_exists "/config/$(bashio::config 'database_path')"; then
    bashio::exit.nok 'The configured database file is not found'
fi
