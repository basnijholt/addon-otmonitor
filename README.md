# [`otmonitor`](http://otgw.tclcode.com/otmonitor.html) Home Assistant supervisor add-on

Install by going to Supervisor -> Add-on store -> Add new repository by url and fill in `https://github.com/basnijholt/addon-otmonitor`.

Then install `otmonitor`.

Example config for the add-on:
```yaml
otgw_host: 192.168.1.26
otgw_port: 6638
relay_port: 7686
mqtt_broker: addon_core_mosquitto
mqtt_port: 1883
mqtt_username: mqtt
mqtt_password: PASSWORD_HERE
```

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
