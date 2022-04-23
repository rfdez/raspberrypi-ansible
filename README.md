# Raspberry PI 4 Setup

> 💡 **First steps**: View the [First steps](doc/FIRT_STEPS.md) doc for instructions on how to install the operating system and boot the Raspberry PI 4 by an USB drive.

> 💡 **Recomendations**: View the [Recommendations](doc/RECOMMENDATIONS.md) doc for instructions on how to improve the security of the Raspberry PI 4.

## Example with multipass

For the quick creation of virtual machines, I have added a script that provisions a bunch of nodes via [multipass](https://github.com/canonical/multipass) and another small Python script that generates an Ansible inventory from the created instances.

Steps:

Create 5 instances with multipass and import your ssh public key with cloud-init (`multipass_create_instances.sh`):

```ShellSession
$ ./tools/multipass_create_instances.sh
Create cloud-init to import ssh key...
[1/5] Creating instance k0s-1 with multipass...
Launched: k0s-1
...
Name                    State             IPv4             Image
k0s-1                   Running           192.168.64.32    Ubuntu 20.04 LTS
k0s-2                   Running           192.168.64.33    Ubuntu 20.04 LTS
k0s-3                   Running           192.168.64.56    Ubuntu 20.04 LTS
k0s-4                   Running           192.168.64.57    Ubuntu 20.04 LTS
k0s-5                   Running           192.168.64.58    Ubuntu 20.04 LTS
```

Generate your Ansible inventory like the `example` file, you will only need to add the IP address of the created instances.

## Cheet Sheet

Use `make env=<environment>` to build the environment. The environment is the name of the file that contains the Ansible inventory. Check the `sample` file for an example. This command will apply the `site.yml` Ansible playbook. It also will check the dependencies that the project requires and the requirements, Ansible collections and roles.

To reset the environment, use `make reset env=<environment>`. It will apply the `reset.yml` playbook to remove the `k0s` cluster installation.

With `make ping env=<environment>` you can check the connection with the hosts defined in the inventory file.

Run `make lint` to check the code style using [ansible-lint](https://github.com/ansible-community/ansible-lint) and [yamllint](https://github.com/adrienverge/yamllint).

## Want to throw away your cluster and start all over?

```ShellSession
$ multipass delete $(multipass list --format csv | grep 'k0s' | cut -d',' -f1)
$ multipass purge
```

---

See the [FEATURES.md](doc/FEATURES.md) for more information.

Follow the [NEXT_STEPS.md](doc/NEXT_STEPS.md) file recommendations for the next steps.
