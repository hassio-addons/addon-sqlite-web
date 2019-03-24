#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: SQLite Web
# This files check if all user configuration requirements are met
# ==============================================================================

# Check SSL cerrificate
bashio::config.require.ssl 'ssl' 'certfile' 'keyfile'

# Check if database file exist
if ! bashio::fs.file_exists "/config/$(bashio::config 'database_path')"; then
    bashio::exit.nok 'The configured database file is not found'
fi
