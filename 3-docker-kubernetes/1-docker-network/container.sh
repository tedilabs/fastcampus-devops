#!/usr/bin/env sh

docker run -d --name=my-nginx nginx
docker run -i -t --network=container:my-nginx ubuntu:focal
