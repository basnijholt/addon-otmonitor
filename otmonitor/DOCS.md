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
credentials that the addon should use to connect to an MQTT broker (only required if `mqtt.autoconfig` is disabled, which is the default option).

This add-on has a couple of options available. To get the add-on running:

1. Fill in the required configuration.
2. Start the add-on.
3. Grab a coffee and wait a couple of minutes.
4. Check the add-on log output to see if the addon was started successfully.


## Configuration

Add-on configuration:

```yaml
otgw:
  host: 192.168.1.24
  port: 6638
  relay_port: 7686

mqtt:
  autoconfig: false
  broker: addon_core_mosquitto
  port: 1883
  username: mqtt
  password: password_here
  client_id: otmonitor
  event_topic: "events/central_heating/otmonitor"
  action_topic: "actions/otmonitor"
  data_format: raw

html_templates:
  enabled: false
  editable: false
```

### Option: `otgw`

- Subkey: `host`
  - Description: The host or ip to connect to the OTGW.
  - This setting is required
  - Default value: `192.168.1.24`
  - Type: String

- Subkey: `port`
  - Description: The port to connect to on the OTGW.
  - This setting is required
  - Default value: `6638`
  - Type: Integer

- Subkey: `relay_port`
  - Description: The port for relaying opentherm messages.
  - This setting is required
  - Default value: `7686`
  - Type: Integer


### Option: `mqtt`

- Subkey: `autoconfig`
  - Description: Retrieve the MQTT broker host, port and credentials from supervisor. (When using the mosquitto addon)
  - This setting is required
  - Default value: `false`
  - Type: Boolean

- Subkey: `broker`
  - Description: The host or ip to connect to the MQTT broker.
  - This setting is only required when `mqtt.autoconfig` is set to false.
  - Default value: `addon_core_mosquitto`
  - Type: String

- Subkey: `port`
  - Description: The port to connect to on the MQTT broker.
  - This setting is only required when `mqtt.autoconfig` is set to false.
  - Default value: `1883`
  - Type: Integer

- Subkey: `username`
  - Description: The username for authenticating on the MQTT broker.
  - This setting is only required when `mqtt.autoconfig` is set to false.
  - Default value: `mqtt`
  - Type: String

- Subkey: `password`
  - Description: The password for authenticating on the MQTT broker.
  - This setting is only required when `mqtt.autoconfig` is set to false.
  - Default value: `password_here`
  - Type: String

- Subkey: `client_id`
  - Description: The client identifier for the mqtt connection
  - This setting is required
  - Default value: `otmonitor`
  - Type: String

- Subkey: `action_topic`
  - Description: The topic for controlling the otgw over mqtt.
  - This setting is required
  - Default value: `actions/otmonitor`
  - Type: String

- Subkey: `event_topic`
  - Description: The topic for receiving otgw events over mqtt.
  - This setting is required
  - Default value: `events/central_heating/otmonitor`
  - Type: String


### Option: `html_templates` (Beta)

- Subkey: `enabled`
  - Description: Instead of the default layout, include the custom html templates that are provided with this plugin.
  - This setting is required
  - Default value: `false`
  - Type: Boolean

- Subkey: `editable`
  - Description: Make the custom html templates edittable in `/share/otmonitor/html`.
  - This setting is required
  - Default value: `false`
  - Type: Boolean


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
