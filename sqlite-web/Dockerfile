ARG BUILD_FROM=hassioaddons/base:2.3.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
  apk add --no-cache --virtual .build-dependencies \
    g++=6.4.0-r9 \
    gcc=6.4.0-r9 \
    make=4.2.1-r2 \
    python3-dev=3.6.6-r0 \
  && apk add --no-cache \
    apache2-utils=2.4.38-r3 \
    nginx=1.14.2-r0 \
    python3=3.6.6-r0 \
    cython=0.28.2-r0 \
  && pip3 install --no-cache-dir  \
    flask==1.0.2 \
    peewee==3.9.3 \
    sqlite-web==0.3.5 \
    datasette==0.27 \
  && apk del --purge .build-dependencies \
  && find /usr/lib/python3.6/ -type d -name test -depth -exec rm -rf {} \; \
  && find /usr/lib/python3.6/ -type d -name tests -depth -exec rm -rf {} \; \
  && find /usr/lib/python3.6/ -name __pycache__ -depth -exec rm -rf {} \;

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Sqlite-web" \
    io.hass.description="Explore your SQLite database" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Joakim Sørensen @ludeeus <ludeeus@gmail.com>" \
    org.label-schema.description="Explore your SQLite database" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Sqlite-web" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-sqlite-web/68912" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-sqlite-web/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-sqlite-web" \
    org.label-schema.vendor="Community Hass.io Add-ons"
