# Home Assistant Add-on: Opentherm Monitor

This addon provides the web ui of the [otmonitor](https://otgw.tclcode.com/otmonitor.html) application,
that can be used for monitoring and managing your opentherm gateway.

## Installation

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Select "Add new repository by url" and fill in `https://github.com/basnijholt/addon-otmonitor`.
2. Find the "otmonitor" add-on and click it.
3. Click on the "INSTALL" button.


## Usage

To get the addon running, some configuration needs to be updated prior to starting.

This includes the host and port on which the addon can access your opentherm gateway and the
credentials that the addon should use to connect to an MQTT broker (only required if `mqtt_autoconfig` is disabled, which is the default option).

This add-on has a couple of options available. To get the add-on running:

1. Fill in the required configuration.
2. Start the add-on.
3. Grab a coffee and wait a couple of minutes.
4. Check the add-on log output to see if the addon was started successfully.


## Configuration

Add-on configuration:

```yaml
otgw_host: 192.168.1.24
otgw_port: 6638
relay_port: 7686
mqtt_broker: addon_core_mosquitto
mqtt_port: 1883
mqtt_username: mqtt
mqtt_password: password_here
mqtt_autoconfig: false
```

### Option: `otgw_host`

Description: The host or ip to connect to the OTGW.
Default value: `192.168.1.24`
Type: String

### Option: `otgw_port`

Description: The port to connect to on the OTGW.
Default value: `6638`
Type: Integer

### Option: `relay_port`

Description: The port for relaying opentherm messages.
Default value: `7686`
Type: Integer

### Option: `mqtt_broker`

Description: The host or ip to connect to the MQTT broker.
Default value: `addon_core_mosquitto`
Type: String

### Option: `mqtt_port`

Description: The port to connect to on the MQTT broker.
Default value: `1883`
Type: Integer

### Option: `mqtt_username`

Description: The username for authenticating on the MQTT broker.
Default value: `mqtt`
Type: String

### Option: `mqtt_password`

Description: The password for authenticating on the MQTT broker.
Default value: `password_here`
Type: String

### Option: `mqtt_client_id`

Description: The client identifier for the mqtt connection
Default value: `otmonitor`
Type: String

### Option: `mqtt_autoconfig`

Description: Retrieve the MQTT broker host, port and credentials from supervisor. (For use with the mosquitto addon)
Default value: `false`
Type: Boolean

### Option: `html_templates.enabled`

Description: Instead of the default layout, include the custom html templates that are provided with this plugin (Beta).
Default value: `false`
Type: Boolean

### Option: `html_templates.editable`

Description: Make the custom html templates edittable in `/share/otmonitor/html` (Beta).
Default value: `false`
Type: Boolean


## Integration

Use with the [`climate.mqtt`](https://www.home-assistant.io/integrations/climate.mqtt/) integration.

You can also connect HomeAssistant through [`opentherm_gw`](https://www.home-assistant.io/integrations/opentherm_gw/) integration using `relay_port`.

Example `configuration.yaml` for Home Assistant:
```yaml
climate:
  - platform: mqtt
    name: Thermostat
    current_temperature_topic: events/central_heating/otmonitor/roomtemperature
    temperature_command_topic: actions/otmonitor/setpoint
    temperature_state_topic: events/central_heating/otmonitor/setpoint
    min_temp: 5
    max_temp: 35
    initial: 17
    temp_step: 0.5
    precision: 0.5
```
