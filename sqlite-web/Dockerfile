ARG BUILD_FROM=hassioaddons/base:3.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
RUN \
  apk add --no-cache --virtual .build-dependencies \
    g++=8.3.0-r0 \
    gcc=8.2.0-r2 \
    make=4.2.1-r2 \
    python3-dev=3.6.8-r1 \
  && apk add --no-cache \
    lua-resty-http=0.12-r1 \
    nginx-mod-http-lua=1.14.2-r0 \
    nginx=1.14.2-r0 \
    python3=3.6.8-r1 \
    cython=0.29.2-r0 \
  && pip3 install --no-cache-dir -U -r /tmp/requirements.txt \
  && rm -f -r /tmp/* \
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
