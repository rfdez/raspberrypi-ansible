# Raspberry PI 4 Setup

## Getting Started
Install an operating system withouth an user interface.

![Raspberry Pi OS Lite (64-BIT)](doc/assets/01-os.png "Raspberry Pi OS Lite")

Configure Advanced Options.

![Raspberry Pi Advanced Options (64-BIT)](doc/assets/02-advanced-options.png "Raspberry Pi Advanced Options")

Configure Persistent Settings.

![Raspberry Pi Persistent Settings (64-BIT)](doc/assets/03-persistent-settings.png "Raspberry Pi Persistent Settings")

Write the storage with the configured operating system and insert the SD card into the Raspberry Pi.

## Cheet Sheet

Use `make env=<environment>` to build the environment. The environment is the name of the file that contains the Ansible inventory. Check the `example` file for an example. This command will apply the `site.yml` Ansible playbook. It also will check the dependencies that the project requires and the requirements, Ansible collections and roles.

With `make ping env=<environment>` you can check the connection with the hosts defined in the inventory file.

Run `make lint` to check the code style using [yamllint](https://github.com/adrienverge/yamllint).

---

See the [FEATURES.md](doc/FEATURES.md) for more information.
