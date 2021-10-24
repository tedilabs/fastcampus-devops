#!/usr/bin/env bash

set -euf -o pipefail

LOCALE="ko_KR.UTF-8"

# Install language pack
apt-get install -y language-pack-ko

# Configure locale
locale-gen $LOCALE
