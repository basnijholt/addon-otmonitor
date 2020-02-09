ARG BUILD_FROM=hassioaddons/base:6.0.1
FROM ${BUILD_FROM}

COPY rootfs /

RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

RUN mkdir -p /opt && \
    if [[ "${BUILD_ARCH}" = "aarch64" ]]; then URL_BASE="otmonitor-aarch64"; fi && \
    if [[ "${BUILD_ARCH}" = "amd64" ]]; then URL_BASE="otmonitor-x64"; fi && \
    if [[ "${BUILD_ARCH}" = "armhf" ]]; then URL_BASE="otmonitor-ahf"; fi && \
    if [[ "${BUILD_ARCH}" = "armv7" ]]; then URL_BASE="otmonitor-ahf"; fi && \
    if [[ "${BUILD_ARCH}" = "i386" ]]; then URL_BASE="otmonitor"; fi && \
    wget http://otgw.tclcode.com/download/${URL_BASE} -O /opt/otmonitor && \
    chmod +x /opt/otmonitor

# Labels
LABEL \
    io.hass.name="otmonitor" \
    io.hass.description="otmonitor add-on" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Bas Nijholt <bas@nijho.lt>" \
    org.label-schema.description="otmonitor add-on" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="otmonitor" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/basnijholt/addon-otmonitor/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/basnijholt/addon-otmonitor" \
    org.label-schema.vendor="Bas Nijholt"
