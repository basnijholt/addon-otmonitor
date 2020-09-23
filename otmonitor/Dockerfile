ARG BUILD_FROM=hassioaddons/debian-base
FROM ${BUILD_FROM}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nginx \
        wget \
        python3-tk \
    && rm -fr \
        /tmp/* \
        /etc/nginx \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
    \
    && mkdir -p /var/log/nginx \
    && touch /var/log/nginx/error.log

COPY rootfs /

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

RUN apt update && apt install wget unzip -y
WORKDIR /tmp
RUN wget https://github.com/hvxl/otmonitor/archive/master.zip && \
    unzip master.zip && mv otmonitor-master /otmonitor
WORKDIR /otmonitor
RUN wget -O sdx.kit https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tclkit/sdx-20110317.kit && \
    wget -O tclkit http://otgw.tclcode.com/download/tclkit-x64 && cp tclkit runtime

RUN ./tclkit sdx.kit wrap otmonitor -runtime runtime && \
    cp otmonitor /opt/otmonitor && \
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
