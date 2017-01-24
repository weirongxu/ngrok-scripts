#!/usr/bin/env bash

. scripts/common.sh
. scripts/get_domain.sh
. scripts/get_port.sh

cat <<- EOF

$(success 'Nginx config:')

server {
  listen 80;
  listen [::]:80;
  server_name *.$NGROK_DOMAIN, $NGROK_DOMAIN;
  location / {
    proxy_pass http://127.0.0.1:$NGROK_HTTPS_PORT;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header Host \$http_host;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  }
  access_log off;
  log_not_found off;
}

server {
  listen 443 ssl;
  listen [::]:443 ssl;
  server_name $NGROK_DOMAIN;
  location / {
    proxy_pass http://127.0.0.1:$NGROK_HTTP_PORT;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header Host \$http_host;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  }
  ssl_certificate /tls/server.crt;
  ssl_certificate_key /tls/server.key;
  access_log off;
  log_not_found off;
}

server {
  listen 443 ssl;
  listen [::]:443 ssl;
  server_name *.$NGROK_DOMAIN;
  location / {
    proxy_pass http://127.0.0.1:$NGROK_HTTPS_PORT;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header Host \$http_host;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  }
  ssl_certificate $(pwd)/tls/subdomain-server.crt;
  ssl_certificate_key $(pwd)/tls/subdomain-server.key;
  access_log off;
  log_not_found off;
}
EOF
