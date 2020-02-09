#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: otmonitor
# Handles configuration
# ==============================================================================

bashio::log.info "Initializing the config overwriting."
OTMONITOR_CONF=/etc/otmonitor/otmonitor.conf

otgw_host=$(bashio::config "otgw_host")
otgw_port=$(bashio::config "otgw_port")
mqtt_broker=$(bashio::config "mqtt_broker")
mqtt_port=$(bashio::config "mqtt_port")
mqtt_username=$(bashio::config "mqtt_username")
mqtt_password=`echo -n $(bashio::config "mqtt_password") | base64`

sed -i 's/%%otgw_host%%/${otgw_host}/g' ${OTMONITOR_CONF}
sed -i 's/%%otgw_port%%/${otgw_port}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_broker%%/${mqtt_broker}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_port%%/${mqtt_port}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_username%%/${mqtt_username}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_password%%/${mqtt_password}/g' ${OTMONITOR_CONF}

bashio::log.info "Finished the config overwriting."
