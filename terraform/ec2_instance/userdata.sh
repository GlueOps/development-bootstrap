#!/bin/bash

NONROOT_USER="ubuntu"

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

# Generate kubeconfig for the KinD cluster
sudo -u ${NONROOT_USER} mkdir -p ~/.kube
sudo -u ${NONROOT_USER} kind get kubeconfig > ~/.kube/config

# Add argo helm repo (since it is missing in the deploy argocd script)
helm repo add argo https://argoproj.github.io/argo-helm

# Install argocd
# TODO: pull in argocd.yaml from development-captains repo
source <(curl -s https://raw.githubusercontent.com/GlueOps/development-only-utilities/v0.4.1/tools/glueops-platform/deploy-argocd) && \
    deploy-argocd -c v2.7.11 -h 5.42.2

# Install glueops platform
# TODO: pull in platform.yaml from development-captains repo
source <(curl -s https://raw.githubusercontent.com/GlueOps/development-only-utilities/v0.4.1/tools/glueops-platform/deploy-glueops-platform) && \
    deploy-glueops-platform -v v0.30.0