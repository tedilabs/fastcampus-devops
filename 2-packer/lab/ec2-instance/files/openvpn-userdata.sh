#!/bin/bash

export OVPN_NETWORK="172.22.0.0 255.255.240.0"
export OVPN_ROUTES="172.22.0.0 255.255.240.0, 10.222.0.0 255.255.0.0"
export OVPN_DNS_SERVERS="10.222.0.2"

/opt/openvpn/run-docker-openvpn.sh
