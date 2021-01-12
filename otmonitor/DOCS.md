# Home Assistant Add-on: Opentherm Monitor

This addon provides the web ui of the [otmonitor](https://otgw.tclcode.com/otmonitor.html) application,
that can be used for monitoring and managing your opentherm gateway.

## Installation

Install by going to Supervisor -> Add-on store -> Add new repository by url and fill in `https://github.com/basnijholt/addon-otmonitor`.


```txt
https://github.com/hassio-addons/repository-test
```


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
4. Check the add-on log output to see if the addon was started succesfully.


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



