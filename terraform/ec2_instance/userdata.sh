#!/bin/bash

export NONROOT_USER="ubuntu"

# Create a KIND cluster
kind create cluster --config=- <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: kind
nodes:
  - role: control-plane
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "glueops.dev/role=glueops-platform"
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "glueops.dev/role=glueops-platform"
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "glueops.dev/role=glueops-platform"
EOF

# Generate kubeconfig for the Kind cluster
sudo -u ${NONROOT_USER} mkdir -p /home/${NONROOT_USER}/.kube
sudo -u ${NONROOT_USER} kind get kubeconfig > /home/${NONROOT_USER}/.kube/config
sudo -u ${NONROOT_USER} chmod 400 /home/${NONROOT_USER}/.kube/config