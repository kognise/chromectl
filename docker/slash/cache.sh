#!/usr/bin/env bash
set -e

CONFPATH=/etc/apt/apt.conf.d/01proxy
HOST_IP=$(awk '/^[a-z0-9]+\t00000000/ { printf("%d.%d.%d.%d\n", "0x" substr($3, 7, 2), "0x" substr($3, 5, 2), "0x" substr($3, 3, 2), "0x" substr($3, 1, 2)) }' < /proc/net/route)

if [[ ! -z "$APT_PROXY_PORT" ]] && [[ ! -z "$HOST_IP" ]]; then
  cat > $CONFPATH <<-EOL
    Acquire::HTTP::Proxy "http://${HOST_IP}:${APT_PROXY_PORT}";
    Acquire::HTTPS::Proxy "false";
EOL
  cat $CONFPATH
  echo "Using host's apt proxy"
else
  echo "No squid-deb-proxy detected on docker host"
fi