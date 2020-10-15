#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SQLite Web
# This files adds some patches to the add-on
# ==============================================================================

# Check if database file exist
if ! bashio::fs.file_exists "/config/$(bashio::config 'database_path')"; then
    bashio::exit.nok 'The configured database file is not found'
fi

# Adds favicon
mv \
    /www/favicon.png \
    /usr/lib/python3.8/site-packages/sqlite_web/static/img/

patch \
    /usr/lib/python3.8/site-packages/sqlite_web/templates/base.html \
    /patches/favicon

# Adds buymeacoffe link
patch \
    /usr/lib/python3.8/site-packages/sqlite_web/templates/base_tables.html \
    /patches/buymeacoffee
