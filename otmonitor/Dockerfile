ARG BUILD_FROM=hassioaddons/base:6.0.1
FROM ${BUILD_FROM}

COPY otmonitor.conf /data/otmonitor.conf

COPY run.sh /

RUN apk add --no-cache wget=1.20.3-r0

RUN mkdir /app && \
    mkdir /data && \
    && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then ARCH="-aarch64"; fi \
    && if [[ "${BUILD_ARCH}" = "amd64" ]]; then ARCH="-x64"; fi \
    && if [[ "${BUILD_ARCH}" = "armhf" ]]; then ARCH="-ahf"; fi \
    && if [[ "${BUILD_ARCH}" = "i386" ]]; then ARCH=""; fi \
    /usr/bin/wget http://otgw.tclcode.com/download/otmonitor${ARCH} -O /app/otmonitor && \
    chmod +x /app/otmonitor

CMD ["/run.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

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
