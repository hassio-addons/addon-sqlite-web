#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SQLite Web
# This files adds some patches to the add-on
# ==============================================================================

# Adds buymeacoffe link
patch \
    /usr/lib/python3.8/site-packages/sqlite_web/templates/base_tables.html \
    /patches/buymeacoffee
