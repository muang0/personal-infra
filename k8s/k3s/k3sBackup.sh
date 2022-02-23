#!/bin/bash

# Store etcd snapshot in s3
k3s etcd-snapshot \
  --s3 \
  --s3-bucket=personal-infra \
  --s3-folder=k3s/etcd-backups \
  --name=mgmt-cluster \
  --s3-access-key=$AWS_ACCESS_KEY_ID_K3S \
  --s3-secret-key=$AWS_SECRET_ACCESS_KEY_K3S

# Prune old snapshots
k3s etcd-snapshot prune \
  --s3 \
  --s3-bucket=personal-infra \
  --s3-folder=k3s/etcd-backups \
  --name=mgmt-cluster \
  --snapshot-retention=2 \
  --s3-access-key=$AWS_ACCESS_KEY_ID_K3S \
  --s3-secret-key=$AWS_SECRET_ACCESS_KEY_K3S

# teardown k3s
/usr/local/bin/k3s-killall.sh
