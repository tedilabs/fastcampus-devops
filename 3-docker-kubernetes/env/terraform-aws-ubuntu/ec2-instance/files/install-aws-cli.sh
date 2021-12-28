#!/usr/bin/env bash
## INFO: https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2-linux.html

set -euf -o pipefail

# Install dependencies
sudo apt-get install -y curl unzip

pushd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

popd
