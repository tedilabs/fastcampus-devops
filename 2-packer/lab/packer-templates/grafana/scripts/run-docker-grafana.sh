#!/usr/bin/env bash

set -euf -o pipefail

GRAFANA_VERSION=8.2.0

## Run Grafana automatically with Docker
docker run \
  -d \
  -p 3000:3000 \
  --restart unless-stopped \
  --name=grafana \
  grafana/grafana:$GRAFANA_VERSION
