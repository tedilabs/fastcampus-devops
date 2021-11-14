#!/usr/bin/env bash

set -euf -o pipefail

# Set default answer for any questions a package might ask
export DEBIAN_FRONTEND=noninteractive

# Retrieve APT package sources
sudo apt-get update -qq

# Install the newest versions of all installed packages
sudo apt-get upgrade -y
