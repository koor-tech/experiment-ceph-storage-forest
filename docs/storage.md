# Storage

This document contains assumptions notes on the expected storage configuration.

## Storage per-device

### 2x ODROID M1 (NVME + SSD)

The ODROID M1s should be loaded with 1x NVMe, 1x SSD.

Executing `lsblk` should render output like the following:

```console
odroid@ctrl0:~$ lsblk
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda            8:0    0 465.8G  0 disk
mtdblock0     31:0    0   128K  0 disk
mtdblock1     31:1    0     2M  0 disk
mtdblock2     31:2    0     1M  0 disk
mtdblock3     31:3    0    12M  0 disk
mmcblk0      179:0    0   7.3G  0 disk
├─mmcblk0p1  179:1    0   256M  0 part /boot
└─mmcblk0p2  179:2    0     7G  0 part /
mmcblk0boot0 179:32   0     4M  1 disk
mmcblk0boot1 179:64   0     4M  1 disk
nvme0n1      259:0    0 232.9G  0 disk
```

Note that the NVMe drive is named `nvmeXnY` and the SSD is named `sda`, while the eMMC is named `mmcblkX`.

### 1x ODROID M1 (2x HDD) / ODROID HC4 (2x HDD)

Executing `lsblk` should render output like the following:

```console
$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0  1.8T  0 disk
sdb           8:16   0  1.8T  0 disk
mmcblk1     179:0    0 29.8G  0 disk
|-mmcblk1p1 179:1    0  128M  0 part /media/boot
`-mmcblk1p2 179:2    0 29.7G  0 part /
```

Note that the hard drives are named `sdX`.
