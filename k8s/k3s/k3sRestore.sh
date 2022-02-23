#!/bin/bash

# Restore k3s from s3 etcd backup
k3s server \
  --etcd-s3 \
  --etcd-s3-bucket=personal-infra \
  --etcd-s3-folder=k3s/etcd-backups \
  --write-kubeconfig-mode=644 \
  --etcd-s3-access-key=$AWS_ACCESS_KEY_ID_K3S \
  --etcd-s3-secret-key=$AWS_SECRET_ACCESS_KEY_K3S
