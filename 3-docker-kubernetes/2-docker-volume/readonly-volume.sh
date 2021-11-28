#!/usr/bin/env sh

docker run \
  -d \
  -v $(pwd)/html:/usr/share/nginx/html:ro \
  -p 80:80 \
  --name ro-nginx \
  nginx

docker exec ro-nginx touch /usr/share/nginx/html/hello
