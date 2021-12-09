#!/usr/bin/env sh

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/CN=fastcampus.com" -keyout cert.key -out cert.crt

kubectl create secret tls my-tls \
  --cert cert.crt \
  --key cert.key \
  --dry-run -o yaml
