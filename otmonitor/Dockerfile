ARG BUILD_FROM=hassioaddons/base:6.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

COPY otmonitor.conf /data/otmonitor.conf

CONFIG_PATH=/data/options.json

OTMONITOR_CONF=/data/otmonitor.conf

otgw_host=$(jq --raw-output ".otgw_host" $CONFIG_PATH)
otgw_port=$(jq --raw-output ".otgw_port" $CONFIG_PATH)
mqtt_broker=$(jq --raw-output ".mqtt_broker" $CONFIG_PATH)
mqtt_port=$(jq --raw-output ".mqtt_port" $CONFIG_PATH)
mqtt_username=$(jq --raw-output ".mqtt_username" $CONFIG_PATH)
mqtt_password=$(jq --raw-output ".mqtt_password" $CONFIG_PATH)

sed -i 's/otgw_host/${otgw_host}/g' ${OTMONITOR_CONF}
sed -i 's/otgw_port/${otgw_port}/g' ${OTMONITOR_CONF}
sed -i 's/mqtt_broker/${mqtt_broker}/g' ${OTMONITOR_CONF}
sed -i 's/mqtt_port/${mqtt_port}/g' ${OTMONITOR_CONF}
sed -i 's/mqtt_username/${mqtt_username}/g' ${OTMONITOR_CONF}
sed -i 's/mqtt_password/${mqtt_password}/g' ${OTMONITOR_CONF}


# Setup base
RUN apk add --no-cache \
    wget=1.20.3-r0

RUN mkdir /app && \
    mkdir /data && \
    && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then ARCH="-aarch64"; fi \
    && if [[ "${BUILD_ARCH}" = "amd64" ]]; then ARCH="-x64"; fi \
    && if [[ "${BUILD_ARCH}" = "armhf" ]]; then ARCH="-ahf"; fi \
    && if [[ "${BUILD_ARCH}" = "i386" ]]; then ARCH=""; fi \
    /usr/bin/wget http://otgw.tclcode.com/download/otmonitor${ARCH} -O /app/otmonitor && \
    chmod +x /app/otmonitor

CMD ["/app/otmonitor", "--daemon", "-f", ${OTMONITOR_CONF}]

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
