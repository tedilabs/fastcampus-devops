#!/usr/bin/env bash
## INFO: https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

set -euf -o pipefail

KUSTOMIZE_VERSION=v4.4.1

# Download kustomize binary
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/kustomize/${KUSTOMIZE_VERSION}/hack/install_kustomize.sh"  | bash

# Install to /usr/local/bin
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
