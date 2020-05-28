ARG BUILD_FROM=hassioaddons/base-python:5.2.1
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
    g++=9.2.0-r4 \
    gcc=9.2.0-r4 \
    make=4.2.1-r2 \
  \
  && apk add --no-cache \
    nginx-mod-http-lua=1.16.1-r6 \
    lua-resty-http=0.15-r0 \
    nginx=1.16.1-r6 \
    cython=0.29.14-r0 \
  \
  && pip3 install \
    --no-cache-dir \
    --prefer-binary \
    --find-links "https://wheels.hass.io/alpine-3.11/${BUILD_ARCH}/" \
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
    org.opencontainers.image.title="Sqlite-web" \
    org.opencontainers.image.description="Explore your SQLite database" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Joakim Sørensen @ludeeus <ludeeus@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/hassio-addons/addon-sqlite-web" \
    org.opencontainers.image.documentation="https://github.com/hassio-addons/addon-sqlite-web/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
