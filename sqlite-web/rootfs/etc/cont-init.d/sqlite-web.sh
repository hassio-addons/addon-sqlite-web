#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SQLite Web
# This files adds some patches to the add-on
# ==============================================================================
folder_path=/config/
if bashio::config.has_value 'folder_path'; then
    folder_path=$(bashio::config 'folder_path')
fi
# Check if database file exist
if ! bashio::fs.file_exists "$folder_path$(bashio::config 'database_path')"; then
    bashio::exit.nok 'The configured database file is not found'
fi

# Adds favicon
mv \
    /www/favicon.png \
    /usr/local/lib/python3.8/site-packages/sqlite_web/static/img/

patch \
    /usr/local/lib/python3.8/site-packages/sqlite_web/templates/base.html \
    /patches/favicon

# Adds buymeacoffe link
patch \
    /usr/local/lib/python3.8/site-packages/sqlite_web/templates/base_tables.html \
    /patches/buymeacoffee
