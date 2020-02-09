CONFIG_PATH=/data/options.json

OTMONITOR_CONF=/etc/otmonitor/otmonitor.conf

otgw_host=$(jq --raw-output ".otgw_host" $CONFIG_PATH)
otgw_port=$(jq --raw-output ".otgw_port" $CONFIG_PATH)
mqtt_broker=$(jq --raw-output ".mqtt_broker" $CONFIG_PATH)
mqtt_port=$(jq --raw-output ".mqtt_port" $CONFIG_PATH)
mqtt_username=$(jq --raw-output ".mqtt_username" $CONFIG_PATH)
mqtt_password=$(jq --raw-output ".mqtt_password" $CONFIG_PATH)

mqtt_password_base64=`echo -n ${mqtt_password} | base64`

sed -i 's/%%otgw_host%%/${otgw_host}/g' ${OTMONITOR_CONF}
sed -i 's/%%otgw_port%%/${otgw_port}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_broker%%/${mqtt_broker}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_port%%/${mqtt_port}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_username%%/${mqtt_username}/g' ${OTMONITOR_CONF}
sed -i 's/%%mqtt_password%%/${mqtt_password_base64}/g' ${OTMONITOR_CONF}

/app/otmonitor --daemon -f ${OTMONITOR_CONF}
