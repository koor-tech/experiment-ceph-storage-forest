# Rook/Ceph Storage Forest

![Storage Forest Logo](./ceph-storage-forest-logo.png)

This repository contains the infrastructure code needed to run a proof of concept "Storage Forest" with [Rook][rook]/[Ceph][ceph].

A "Storage Forest" is a storage network spanning many different devices and strategies for storing data, mimicking the diversity of a physical forest.

[rook]: https://docs.rook.io
[ceph]: https://docs.ceph.com

## Why?

Different storage mechanisms are good for different cost profiles, but there's been less excitement around heterogeneous SANs. In 2022 (when this project was completed) Ceph is capable of combining consumer and enterprise grade storage into a heterogeneous SAN quite easily, and with the addition of Rook and Kubernetes, making that storage easier to access than ever before.

Rook and Ceph combine to provide:

- Flexible storage provisioning and orchestration with Rook
- [RBD mirroring][ceph-rbd-mirroring] for moving data between storage classes
- [Image Live Migration][ceph-live-migration]
- [Object Storage][ceph-obj-gateway] (S3 & Swift compatibility)
- [Shared Filesystem][cephfs] (similar to NFS)
- [network block device][ceph-rbd] (a la `nbd`/ISCSI)

With some automation, workloads can be moved between tiers of service and automatic mirroring and backup archival system can be built, and that's just the beginning!

[ceph-rbd-mirroring]: https://docs.ceph.com/en/latest/rbd/rbd-mirroring/
[ceph-live-migration]: https://docs.ceph.com/en/latest/rbd/rbd-live-migration/

## Setup

This particular Storage Forest has the components listed below.

### Compute

- 2x [ODROID M1][odroid-m1]
- 1x [ODROID HC4][odroid-hc4]

For more complete directions on how to prep the compute nodes, see [`docs/compute-setup.md`](./docs/setup-compute.md).

[odroid-m1]: https://www.hardkernel.com/shop/odroid-m1-with-8gbyte-ram/
[odroid-hc4]: https://www.hardkernel.com/shop/odroid-hc4/

### Storage

- 2x eMMC (for OS
- 2x NVMe
- 2x SSD
- 2x HDD

## Management

As you might imagine, combining the disparate components of the storage forest is a complicated task.

The forest is managed with:

- [Ansible][ansible] for bare metal terraforming
- [Kubernetes][k8s] (deployed with [k0s][k0s]) for workload orchestration
- [Ceph][ceph] (via [Rook][rook] for storage management) for storage orchestration

While other systems may have done the job, this stack is wonderfully robust and current.

## Getting started

You can replicate this setup yourself with the exact same or comparable hardware.

### 1. Update the Ansible Inventory

Update [`ansible/inventory.yml`](./ansible/inventory.yml) with the correct IPs for machines you want to configure

### 2. Prepare the hardware

See `docs/compute-setup.md` for full instructions on how to set up [HardKernel ODROID][odroid] hardware.

### 3. Set up the cluster

You can kick off the automation that will provision and terraform the machines by running `make`:

```console
make
```

`make` will:

- Run `ansible`
- Run `k0sctl` to provision a kubernetes cluster
- Install `rook`
- Set up expected `StorageClass`es and other requirements for using the cluster

### 3. Run some workloads

After the cluster has been set up, cluster configurations will be available locally to use to run workloads.

There are a few `make` targets that will run example workloads for you:

- `make example-workload-minio`
- `make example-workload-harbor`

## Special features

Along with simply creating a storage network spanning different kinds of devices, the Stoarge Forest

[rook]: https://docs.rook.io
[ceph]: https://docs.ceph.com
[odroid]: https://www.hardkernel.com/
[odroid-m1]: https://www.hardkernel.com/shop/odroid-m1-with-8gbyte-ram/
[odroid-hc4]: https://www.hardkernel.com/shop/odroid-hc4/
[ceph-rbd-mirroring]: https://docs.ceph.com/en/latest/rbd/rbd-mirroring/
[ceph-live-migration]: https://docs.ceph.com/en/latest/rbd/rbd-live-migration/
[ceph-obj-gateway]: https://docs.ceph.com/en/latest/radosgw/
[cephfs]: https://docs.ceph.com/en/latest/cephfs/
[ceph-rbd]: https://docs.ceph.com/en/latest/rbd
[repo]: https://gitlab.com/opencore-ventures/experiment-ceph-storage-forest
[ansible]: https://docs.ansible.com
[k8s]: https://kubernetes.io/docs
[k0s]: https://docs.k0sproject.io/
