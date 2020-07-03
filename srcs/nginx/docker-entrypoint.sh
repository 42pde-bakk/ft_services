#!/usr/bin/env sh
set -eu

cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.template
envsubst '${PHPMYADMIN_SVC_SERVICE_HOST} ${PHPMYADMIN_SVC_SERVICE_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"
