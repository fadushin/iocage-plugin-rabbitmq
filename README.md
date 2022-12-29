# iocage-plugin-rabbitmq

This [iocage](https://iocage.readthedocs.io/en/latest/index.html) plugin can be used to create a [FreeBSD](https://freebsd.org) jail with a running instance of [RabbitMQ](https://www.rabbitmq.com).

A single administrative user (`admin`) is created.

The RabbitMQ [Management plugin](https://www.rabbitmq.com/management.html) is enabled, allowing a web-based interface to manage the RabbitMQ instance.

## Usage

For standalone (FrreBSD) installations, first fetch the JSON descriptor for the plugin:

    fetch https://raw.githubusercontent.com/fadushin/iocage-plugin-rabbitmq/<branch>/rabbitmq.json

where `<branch>` is the version you want (e.g., `13.1-RELEASE`).

And then install the plugin via `iocage`:

    iocage fetch -P ./rabbitmq.json --name <name>

where `<name>` is a jail name of your choosing (`rabbitmq` will be used if no name is specified).
