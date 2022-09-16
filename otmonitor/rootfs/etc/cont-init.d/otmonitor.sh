#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: otmonitor
# Handles configuration
# ==============================================================================

bashio::log.info "Initializing service configuration."

OTMONITOR_CONF=/etc/otmonitor/otmonitor.conf

# ======================================
# Functions
# ======================================

function setconf() {
    key="${2}"
    value="${4}"

    sed -i "s|%%${key}%%|${value}|g" ${OTMONITOR_CONF}
}

# ======================================
# Configure custom html templates
# ======================================

if bashio::config.true 'html_templates.enabled'; then
    bashio::log.info "Setting up html template files for otmonitor"

    if bashio::config.true 'html_templates.editable' ; then
        template_source=/share/otmonitor/html
    else
        template_source=/usr/share/otmonitor/html
    fi

    if ! bashio::fs.directory_exists "${template_source}" ; then
        bashio::log.info "Copying html template files to ${template_source}"

        mkdir -p "${template_source}"
        cp -r /usr/share/otmonitor/html/* "${template_source}/"
    fi

    bashio::log.info "Linking the custom html templates to /opt/html"
    ln -sf "${template_source}" /opt/html
fi


# ======================================
# Update otgw host and ports in config
# ======================================

setconf --key otgw_type   --value "$( bashio::config otgw.type       )"
setconf --key otgw_host   --value "$( bashio::config otgw.host       )"
setconf --key otgw_port   --value "$( bashio::config otgw.port       )"
setconf --key otgw_device --value "$( bashio::config otgw.device     )"
setconf --key relay_port  --value "$( bashio::config otgw.relay_port )"

# ======================================
# Update MQTT settings in config
# ======================================

setconf --key mqtt_enable       --value "$( bashio::config mqtt.enable       )"
setconf --key mqtt_client_id    --value "$( bashio::config mqtt.client_id    )"
setconf --key mqtt_action_topic --value "$( bashio::config mqtt.action_topic )"
setconf --key mqtt_event_topic  --value "$( bashio::config mqtt.event_topic  )"
setconf --key mqtt_data_format  --value "$( bashio::config mqtt.data_format  )"
setconf --key mqtt_all_messages --value "$( bashio::config mqtt.all_messages )"
setconf --key mqtt_qos          --value "$( bashio::config mqtt.qos          )"
setconf --key mqtt_retransmit   --value "$( bashio::config mqtt.retransmit   )"

if bashio::config.true 'mqtt.autoconfig' ; then
    bashio::log.info "Using autoconfig provided MQTT credentials from supervisor"

    setconf --key mqtt_broker   --value "$( bashio::services mqtt host     )"
    setconf --key mqtt_port     --value "$( bashio::services mqtt port     )"
    setconf --key mqtt_username --value "$( bashio::services mqtt username )"
    setconf --key mqtt_password --value "$( bashio::services mqtt password | base64 -w 0 )"
else
    bashio::log.info "Using manually provided MQTT credentials"

    setconf --key mqtt_broker   --value "$( bashio::config mqtt.broker   )"
    setconf --key mqtt_port     --value "$( bashio::config mqtt.port     )"
    setconf --key mqtt_username --value "$( bashio::config mqtt.username )"
    setconf --key mqtt_password --value "$( bashio::config mqtt.password | base64 -w 0 )"
fi

# ======================================
# Update Email settings in config
# ======================================

setconf --key email_enable    --value "$( bashio::config email.enable    )"
setconf --key email_recipient --value "$( bashio::config email.recipient )"
setconf --key email_sender    --value "$( bashio::config email.sender    )"
setconf --key email_server    --value "$( bashio::config email.server    )"
setconf --key email_port      --value "$( bashio::config email.port      )"
setconf --key email_secure    --value "$( bashio::config email.secure    )"
setconf --key email_user      --value "$( bashio::config email.user      )"
setconf --key email_password  --value "$( bashio::config email.password | base64 -w 0 )"

# ======================================
# Update ThingSpeak settings in config
# ======================================

setconf --key tspeak_enable   --value "$( bashio::config tspeak.enable   )"
setconf --key tspeak_interval --value "$( bashio::config tspeak.interval )"
setconf --key tspeak_sync     --value "$( bashio::config tspeak.sync     )"
setconf --key tspeak_key      --value "$( bashio::config tspeak.key      )"

bashio::log.info "Finished updating otmonitor config file."
