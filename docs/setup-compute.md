# Compute Setup

Follow the steps below to set up the compute to form a Kubernetes cluster.

## 1. Set up the eMMC/SD Cards with [Etcher][etcher]

Following the relevant [ODROID documentation][odroid-install-guide], set up Ubuntu 20.04 on the Small Board Computers ("SBC"s) using `etcher`.

[etcher]: https://github.com/balena-io/etcher
[odroid-install-guide]: https://wiki.odroid.com/getting_started/os_installation_guide

## 2. Set up Static IPs for the SBCs

To ensure that the SBCs are reachable at consistent IPs, use the files in `ansible/files/netplan` for each node, to ensure that they receive the following IPs:

- `192.168.1.200` (`ctrl0` - ODROID M1)
- `192.168.1.201` (`worker0` -  ODROID M1)
- `192.168.1.202` (`worker1` - ODROID HC4)

Place the files from the repo in files in `/etc/netplan`. Given an existing DHCP-specified IP `xxx.xxx.xxx.xxx`, you can run the following commands:

```console
scp ansible/files/netplan/ctrl0/10-static-ip.yaml odroid@xxx.xxx.xxx.xxx:/tmp/10-static-ip.yaml
ssh odroid@xxx.xxx.xxx.xxx
sudo mv /tmp/10-static-ip.yaml /etc/netplan # (run from the machine @ xxx.xxx.xxx.xxx)
```

**NOTE** You may have to change the `gateway4` for the netplan if your router uses `192.168.0.1` as a gateway intead of `192.168.1.1` (you can check `ip route` from the SBC in default configuration to find out the right gateway).

After getting the `netplan` config in place, generate and apply:

```console
sudo netplan generate
sudo netplan apply
```

The SSH connection will likely break, but afterward you should be able to connect to the machines on their new IPs.

## 3. Set up ENV

Before the automation has run, make sure to set up ENV variables that will be used:

```console
export NODE_SSH_PASSWORD=odroid
export SSH_ACCESS_PUB_KEY_PATH=/absolute/path/to/your/id_rsa.pub
```

Easy management of ENV variables can be done with [`direnv`](https://direnv.net).

## 5. Run automation

The rest of the automation (Ansible, k0s, etc) can be run from the `Makefile` in the root of the project.

```console
make
```
