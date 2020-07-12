#!/usr/bin/env sh
set -eu

cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.template
envsubst '${PHPMYADMIN_SVC_SERVICE_HOST} ${PHPMYADMIN_SVC_SERVICE_PORT} ${WORDPRESS_SVC_SERVICE_HOST} ${WORDPRESS_SVC_SERVICE_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# cp /var/www/localhost/htdocs/index.html /var/www/localhost/htdocs/indexcopy.html
# envsubst '${PHPMYADMIN_SVC_SERVICE_HOST} ${PHPMYADMIN_SVC_SERVICE_PORT}' < /var/www/localhost/htdocs/indexcopy.html > /var/www/localhost/htdocs/index.html
# cat /var/www/localhost/htdocs/index.html
# cat /etc/nginx/conf.d/default.conf
exec "$@"
