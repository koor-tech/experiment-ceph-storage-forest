# Setup Compute ODROID HC4 (EXPERIMENTAL)

The [ODROID HC4][odroid-hc4] requires some changes that the M1 and other SBCs do not as they are a little bit older.

## 1. Set up the `odroid` user

Since the default user is `root` instead of `odroid` on HC4 SBCs, they should be changed to match the other nodes.

 sure to set up the `odroid` system user (the default user is `root` which is mismatched with the ODROID M1 and other SBCs):

```console
useradd --create-home --shell /bin/bash odroid
passwd odroid # you'll be prompted for a password
echo "odroid    ALL=(ALL:ALL) ALL" >> /etc/sudoers
```

On machines where the `odroid` *is* present (ex. ODROID M1), you still need to add the `odroid` user to the `admin` group which is allowed to `sudo` without passwords by default:

```console
sudo groupadd admin
sudo usermod -aG admin odroid
```

### 2. Upgrade & re-install the ODROID HC4 linux kernel

If your setup includes an ODROID HC4, you'll need to *upgrade and reconfigure* the linux kernel it uses to enable missing CGroup and other features.

See `ansible/roles/odroid-hc4-rebuilt-kernel/tasks/main.yml` for the steps involved.

This can take quite a while (~89 minutes) so make sure to leave plenty of time for the operation to complete.



