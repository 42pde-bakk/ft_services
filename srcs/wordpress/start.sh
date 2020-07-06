#!/bin/sh

# We retrieve external IP
# IP=$(cat /ip.txt)
# We replace the template IP by the actual kubernetes IP
cp /www/wp-config.php /tmp/wp-configcopy.php
# envsubst '${WORDPRESS_SVC_SERVICE_HOST} ${WORDPRESS_SVC_SERVICE_PORT}' < /tmp/wp-configcopy.php
envsubst '${WORDPRESS_SVC_SERVICE_HOST} ${WORDPRESS_SVC_SERVICE_PORT}' < /tmp/wp-configcopy.php > /www/wp-config.php

# We launch Telegraf and a simple web server hosting Wordpress
# telegraf &
php -S 0.0.0.0:80 -t /www/