#!/usr/bin/env bash

set -euf -o pipefail

apt-get autoremove -y
apt-get clean -y

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
