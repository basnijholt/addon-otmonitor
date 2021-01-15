ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG BUILD_FROM

################################################################################
## Stage 1: Build the otmonitor binary using the tcl/tk toolkit               ##
################################################################################
FROM ${BUILD_FROM} as builder
ARG BUILD_ARCH

SHELL ["/bin/bash", "-o", "pipefail", "+x", "-c"]
WORKDIR /otmonitor

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget \
 && wget -qO /tmp/otm.tgz https://github.com/hvxl/otmonitor/archive/master.tar.gz \
 && tar xzf /tmp/otm.tgz --strip=1 -C . \
 && rm /tmp/otm.tgz \
 && wget -qO ./sdx.kit https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tclkit/sdx-20110317.kit \
 \
 && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then URL_BASE="tclkit-aarch64"; fi \
 && if [[ "${BUILD_ARCH}" = "amd64" ]]; then URL_BASE="tclkit-x64"; fi \
 && if [[ "${BUILD_ARCH}" = "armhf" ]]; then URL_BASE="tclkit-ahf"; fi \
 && if [[ "${BUILD_ARCH}" = "armv7" ]]; then URL_BASE="tclkit-ahf"; fi \
 && if [[ "${BUILD_ARCH}" = "i386" ]]; then URL_BASE="tclkit"; fi \
 && wget -qO tclkit http://otgw.tclcode.com/download/${URL_BASE} \
 && cp tclkit runtime \
 && chmod +x tclkit \
 && ./tclkit sdx.kit wrap otmonitor -runtime runtime


################################################################################
## Stage 2: Build the addon container                                         ##
################################################################################
FROM ${BUILD_FROM}
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        nginx \
        python3-tk \
        unzip \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && rm -fr \
     /tmp/* \
     /var/cache/* \
     /var/lib/apt/lists/* \
     /etc/nginx

COPY rootfs /

WORKDIR /opt
COPY --from=builder /otmonitor/otmonitor .
RUN chmod +x /opt/otmonitor

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

