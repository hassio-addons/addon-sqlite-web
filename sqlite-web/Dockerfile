ARG BUILD_FROM=hassioaddons/base:8.0.3
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
    g++=9.3.0-r2 \
    gcc=9.3.0-r2 \
    make=4.3-r0 \
    py3-pip=20.1.1-r0 \
    python3-dev=3.8.5-r0 \
  \
  && apk add --no-cache \
    nginx-mod-http-lua=1.18.0-r0 \
    lua-resty-http=0.15-r0 \
    nginx=1.18.0-r0 \
    cython=0.29.19-r0 \
    python3=3.8.5-r0 \
  \
  && pip3 install \
    --no-cache-dir \
    --prefer-binary \
    --find-links "https://wheels.hass.io/alpine-3.12/${BUILD_ARCH}/" \
    -r /tmp/requirements.txt \
  \
  && find /usr/local \
    \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' + \
  \
  && apk del --no-cache --purge .build-dependencies \
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
