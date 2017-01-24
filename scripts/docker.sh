#!/usr/bin/env bash
. scripts/get_domain.sh
. scripts/get_port.sh
. scripts/generate_tls.sh

if docker ps -a -q -f="name=ngrokd"; then
  docker create --name=ngrokd --restart=always \
    -p $NGROK_HTTP_PORT:80 -p $NGROK_HTTPS_PORT:443 -p 4443:4443 \
    -v "$(pwd)/tls/server.key:/tls/server.key" -v "$(pwd)/tls/server.crt:/tls/server.crt" \
    sequenceiq/ngrokd -domain=$NGROK_DOMAIN -tlsCrt "/tls/server.crt" -tlsKey "/tls/server.key"
fi

. scripts/echo_ngrok_config.sh
