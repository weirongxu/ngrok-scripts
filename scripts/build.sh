#!/usr/bin/env bash
copy_tls() {
  echo 'Copy tls...'
  cp tls/rootCA.crt ngrok/assets/client/tls/ngrokroot.crt
  cp tls/server.crt ngrok/assets/server/tls/snakeoil.crt
  cp tls/server.key ngrok/assets/server/tls/snakeoil.key
}

. scripts/get_domain.sh
. scripts/get_port.sh
. scripts/generate_tls.sh

if [ ! -d ngrok ]; then
  git clone https://github.com/weirongxu/ngrok.git --depth 1
  sed -i "" "s/ngrokd\\.ngrok\\.com:443/$NGROK_DOMAIN:4443/g" ngrok/src/ngrok/client/model.go
fi

if [ ! -d ngrok ]; then
  echo "Clone error!"
  exit
fi

copy_tls

cd ngrok

echo "$(make release-all)"

cd ..

. scripts/echo_ngrok_config.sh

cat > scripts/run.sh <<-EOF
$(pwd)/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":$NGROK_HTTP_PORT" -srcHttpAddr=":80" -httpsAddr=":$NGROK_HTTPS_PORT" -srcHttpsAddr=":433"
EOF

chmod +x scripts/run.sh
