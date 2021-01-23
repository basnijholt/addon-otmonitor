#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: otmonitor
# Handles configuration
# ==============================================================================

bashio::log.info "Initializing service configuration."

OTMONITOR_CONF=/etc/otmonitor/otmonitor.conf


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

otgw_host="$( bashio::config 'otgw_host' )"
otgw_port="$( bashio::config 'otgw_port' )"
relay_port="$( bashio::config 'relay_port' )"

sed -i "s|%%otgw_host%%|${otgw_host}|g"   ${OTMONITOR_CONF}
sed -i "s|%%otgw_port%%|${otgw_port}|g"   ${OTMONITOR_CONF}
sed -i "s|%%relay_port%%|${relay_port}|g" ${OTMONITOR_CONF}


# ======================================
# Update MQTT settings in config
# ======================================

if bashio::config.true 'mqtt.autoconfig' ; then
    bashio::log.info "Using autoconfig provided MQTT credentials from supervisor"

    mqtt_broker="$( bashio::services mqtt 'host' )"
    mqtt_port="$( bashio::services mqtt 'port' )"
    mqtt_username="$( bashio::services mqtt 'username' )"
    mqtt_password="$( bashio::services mqtt 'password' )"
else
    bashio::log.info "Using manually provided MQTT credentials"

    mqtt_broker="$( bashio::config 'mqtt.broker' )"
    mqtt_port="$( bashio::config 'mqtt.port' )"
    mqtt_username="$( bashio::config 'mqtt.username' )"
    mqtt_password="$( bashio::config 'mqtt.password' )"
fi

mqtt_client_id="$( bashio::config 'mqtt.client_id' )"
mqtt_action_topic="$( bashio::config 'mqtt.action_topic' )"
mqtt_event_topic="$( bashio::config 'mqtt.event_topic' )"
mqtt_password_base64="$( echo -n "${mqtt_password}" | base64 -w 0 )"

sed -i "s|%%mqtt_broker%%|${mqtt_broker}|g"             ${OTMONITOR_CONF}
sed -i "s|%%mqtt_port%%|${mqtt_port}|g"                 ${OTMONITOR_CONF}
sed -i "s|%%mqtt_username%%|${mqtt_username}|g"         ${OTMONITOR_CONF}
sed -i "s|%%mqtt_password%%|${mqtt_password_base64}|g"  ${OTMONITOR_CONF}
sed -i "s|%%mqtt_client_id%%|${mqtt_client_id}|g"       ${OTMONITOR_CONF}
sed -i "s|%%mqtt_event_topic%%|${mqtt_event_topic}|g"   ${OTMONITOR_CONF}
sed -i "s|%%mqtt_action_topic%%|${mqtt_action_topic}|g" ${OTMONITOR_CONF}

bashio::log.info "Finished updating otmonitor config file."
