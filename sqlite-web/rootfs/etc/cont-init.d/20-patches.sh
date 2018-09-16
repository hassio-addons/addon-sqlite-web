#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: SQLite Web
# This files adds some patches to the add-on
# ==============================================================================

# Adds favicon
mv /www/favicon.png /usr/lib/python3.6/site-packages/sqlite_web/static/img/
patch /usr/lib/python3.6/site-packages/sqlite_web/templates/base.html /patches/favicon

# Adds buymeacoffe link
patch /usr/lib/python3.6/site-packages/sqlite_web/templates/base_tables.html /patches/buymeacoffee
