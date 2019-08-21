ARG BUILD_FROM=hassioaddons/base-python:2.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
ARG BUILD_ARCH=amd64
RUN \
  apk add --no-cache --virtual .build-dependencies \
    g++=8.3.0-r0 \
    gcc=8.3.0-r0 \
    make=4.2.1-r2 \
  \
  && apk add --no-cache \
    nginx-mod-http-lua=1.16.1-r0 \
    lua-resty-http=0.13-r0 \
    nginx=1.16.1-r0 \
    cython=0.29.10-r0 \
  \
  && pip3 install \
    --no-cache-dir \
    --prefer-binary \
    --find-links "https://wheels.hass.io/alpine-3.10/${BUILD_ARCH}/" \
    -r /tmp/requirements.txt \
  \
  && find /usr/local \
    \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' + \
  \
  && apk del --purge .build-dependencies \
  && rm -f -r \
    /etc/nginx \
    /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
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
