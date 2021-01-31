# [`otmonitor`](http://otgw.tclcode.com/otmonitor.html) Home Assistant supervisor add-on

## About

Opentherm monitor is a management and monitoring application for your [opentherm gateway](http://otgw.tclcode.com).

## Installation

Install by going to Supervisor -> Add-on store -> Add new repository by url and fill in `https://github.com/basnijholt/addon-otmonitor`.

## Documentation

See [otmonitor/DOCS.md](https://github.com/basnijholt/addon-otmonitor/blob/master/otmonitor/DOCS.md).

## Local development

To locally test or develop on this addon, use vscode as explained in [the home assistant local adding testing developer documentation](https://developers.home-assistant.io/docs/add-ons/testing/).

It takes a while to build, download and start the local devcontainer as it runs a local home assistant instance using docker-in-docker (din), which is slow, but it's very useful to test your local changes.

In short:

- Install [Docker](https://docs.docker.com/install) on your local machine
- Copy the `.devcontainer` directory from the root of the community-addons repository
- Open the project in [Visual Studio Code](https://code.visualstudio.com/)
- Select `Rebuild and Reopen in Container` from the command palette
- Wait until the devcontainer itself is build
- Start the ha instance by running task `Start Home Assistant`
- Grab a coffee and wait until all the required home-assistant containers are up
- Setup your local ha instance on http://localhost:812
- Install mosquitto mqtt broker
- Install the local otmonitor addon
- Test your changes


To build the container manually, use:

```
ARCH=amd64
docker build --build-arg BUILD_FROM=homeassistant/${ARCH}-base-debian:buster  --build-arg BUILD_ARCH=${ARCH} .
```
