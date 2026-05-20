#!/bin/sh
set -e

# Обязательные переменные
: "${BACKEND_HOST:?Переменная BACKEND_HOST не задана}"
: "${BACKEND_PORT:?Переменная BACKEND_PORT не задана}"

# Опциональные — с дефолтами
LISTEN_PORT="${LISTEN_PORT:-8443}"
WS_PATH="${WS_PATH:-/ws}"
GRPC_PATH="${GRPC_PATH:-/grpc}"
XHTTP_PATH="${XHTTP_PATH:-/xhttp}"
ORIGIN_URL="${ORIGIN_URL:-https://www.google.com}"

export LISTEN_PORT WS_PATH GRPC_PATH XHTTP_PATH ORIGIN_URL

echo "Starting nginx:"
echo "  LISTEN_PORT  = $LISTEN_PORT"
echo "  BACKEND_HOST = $BACKEND_HOST"
echo "  BACKEND_PORT = $BACKEND_PORT"
echo "  WS_PATH      = $WS_PATH"
echo "  GRPC_PATH    = $GRPC_PATH"
echo "  XHTTP_PATH   = $XHTTP_PATH"
echo "  ORIGIN_URL   = $ORIGIN_URL"

envsubst '${BACKEND_HOST} ${BACKEND_PORT} ${LISTEN_PORT} ${WS_PATH} ${GRPC_PATH} ${XHTTP_PATH} ${ORIGIN_URL}' \
    < /etc/nginx/nginx.conf.template \
    > /etc/nginx/nginx.conf

nginx -t

exec nginx -g 'daemon off;'
