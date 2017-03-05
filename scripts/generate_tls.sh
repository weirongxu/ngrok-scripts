#!/usr/bin/env bash
. scripts/common.sh
. scripts/get_domain.sh

test ! -d cache && mkdir cache
test ! -d cache/tls && mkdir cache/tls

cd cache/tls

echo 'Create cache/tls...'

if [ ! -f rootCA.key ]; then
  success 'create rootCA.key'
  openssl genrsa -out rootCA.key 4096
else
  error 'exists rootCA.key'
fi

if [ ! -f rootCA.crt ]; then
  success 'create rootCA.crt'
  openssl req -x509 -sha256 -new -nodes -key rootCA.key -subj "/CN=NGROK-ROOT" -days 5000 -out rootCA.crt
else
  error 'exists rootCA.crt'
fi

if [ ! -f server.key ]; then
  success 'create server.key'
  openssl genrsa -out server.key 4096
else
  error 'exists server.key'
fi

if [ ! -f server.csr ]; then
  success 'create server.csr'
  openssl req -new -sha256 -key server.key -subj "/CN=$NGROK_DOMAIN" -out server.csr
else
  error 'exists server.csr'
fi

if [ ! -f server.crt ]; then
  success 'exists server.crt'
  openssl x509 -req -sha256 -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 5000
else
  error 'exists server.crt'
fi

if [ ! -f subdomain-server.key ]; then
  success 'create subdomain-server.key'
  openssl genrsa -out subdomain-server.key 4096
else
  error 'exists subdomain-server.key'
fi

if [ ! -f subdomain-server.csr ]; then
  success 'create subdomain-server.csr'
  openssl req -new -sha256 -key subdomain-server.key -subj "/CN=*.$NGROK_DOMAIN" -out subdomain-server.csr
else
  error 'exists subdomain-server.csr'
fi

if [ ! -f subdomain-server.crt ]; then
  success 'exists subdomain-server.crt'
  openssl x509 -req -sha256 -in subdomain-server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out subdomain-server.crt -days 5000
else
  error 'exists subdomain-server.crt'
fi

cd ../..
