# Recommendations

- [Recommendations](#recommendations)
	- [Update the system](#update-the-system)
	- [Change the default password](#change-the-default-password)
	- [Disable the default account](#disable-the-default-account)
	- [Make sudo require a password](#make-sudo-require-a-password)
	- [SSH](#ssh)
		- [Prevent root login](#prevent-root-login)
		- [Key-Based Authentication](#key-based-authentication)
		- [Change the default port](#change-the-default-port)
	- [Set static IP address](#set-static-ip-address)
	- [Required for k0s](#required-for-k0s)
		- [Configure CGroup](#configure-cgroup)
		- [Swap (Optional)](#swap-optional)
		- [Kernel modules](#kernel-modules)
	- [Additional Recommendations](#additional-recommendations)

## Update the system

Run `sudo apt-get update` and `sudo apt-get upgrade` to update the system.

## Change the default password

Run `passwd` to change the default password.

## Disable the default account

- Create a new user account with the command `sudo adduser <username>`.
- Give the user the `sudo` privilege with the command `sudo adduser <username> sudo`.
- Delete the default user account with the command `sudo deluser -remove-home <default username>`.

## Make sudo require a password

- In a terminal window, run `sudo visudo`.
- Add the following line to the end of the file:
	```
	YOUR_USERNAME_HERE ALL=(ALL) PASSWD: ALL
	```

## SSH

### Prevent root login

- Open the `/etc/ssh/sshd_config` file with a text editor.
- Comment the following line:
	```
	#PermitRootLogin prohibit-password
	```
- Restart the SSH service with `sudo service ssh restart`.

### Key-Based Authentication

- Change this line in the SSH configuration file we saw before:
	```
	PasswordAuthentication no
	```

### Change the default port

- Open the `/etc/ssh/sshd_config` file with a text editor.
- Insert the following line, if it already exists, replace it with the following line:
	```
	Port 1111
	```
- Restart the SSH service with `sudo service ssh restart`.

## Set static IP address

Set the router to always assign the same IP to any device with that MAC address

To find your Pi's MAC address type:
```
ifconfig
```

## Required for k0s

Every node (whether control plane or not) requires additional configuration in preparation for k0s deployment.

### Configure CGroup

- Ensure that the following packages are installed on each node:
	```
	apt-get install cgroup-lite cgroup-tools cgroupfs-mount
	```

- Enable the memory cgroup in the Kernel by adding it to the Kernel command line.

- Open the file /boot/firmware/cmdline.txt (responsible for managing the Kernel parameters), and confirm that the following parameters exist (and add them as necessary):
	```
	cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1
	```

- Be sure to reboot each node to ensure the `memory` cgroup is loaded.

### Swap (Optional)

While swap is technically optional, enable it to ease memory pressure.

- To create a swapfile:

	```bash
	fallocate -l 2G /swapfile && \
	chmod 0600 /swapfile && \
	mkswap /swapfile && \
	swapon -a
	```

- Ensure that the usage of swap is not too agressive by setting the `sudo sysctl vm.swappiness=10` (the default is generally higher) and configuring it to be persistent in `/etc/sysctl.d/*`.

- Ensure that your swap is mounted after reboots by confirming that the following line exists in your `/etc/fstab` configuration:

	```
	/swapfile         none           swap sw       0 0
	```

### Kernel modules

Ensure the loading of the `overlay`, `nf_conntrack` and `br_netfilter` modules:

```
modprobe overlay
modprobe nf_conntrack
modprobe br_netfilter
```

In addition, add each of these modules to your `/etc/modules-load.d/modules.conf` file to ensure they persist following reboot.

## Additional Recommendations

- Automatic backups to restore the system (https://raspberrytips.com/backup-raspberry-pi)
- Two-factor SSH authentication
- Set Hostname
- Restore your Dotfiles following the instructions in the [Dotfiles](https://github.com/rfdez/raspberrypi-dotfiles) repository.
