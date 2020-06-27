#!/bin/sh

# Apache server name change
if [ ! -z "${APACHE_SERVER_NAME}" ]
	then
		sed -i "s/#ServerName www.example.com:80/ServerName ${APACHE_SERVER_NAME}:80/" /etc/apache2/httpd.conf
		echo "Changed server name to '${APACHE_SERVER_NAME}'..."
	else
		echo "NOTICE: Change 'ServerName' globally and hide server message by setting environment variable >> 'SERVER_NAME=your.server.name' in docker command or docker-compose file"
fi

# Start (ensure apache2 PID not left behind first) to stop auto start crashes if didn't shut down properly
echo "Clearing any old processes..."
rm -f /run/apache2/apache2.pid
rm -f /run/apache2/httpd.pid

echo "Updating HTTPD config"
sed -i "s/ErrorLog logs\/error.log/Errorlog \/dev\/stderr\nTransferlog \/dev\/stdout/" /etc/apache2/httpd.conf
sed -i "s/define('DB_NAME', null);/define('DB_NAME', '${MYSQL_DATABASE}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_USER', null);/define('DB_USER', '${MYSQL_USER}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_PASSWORD', null);/define('DB_PASSWORD', '${MYSQL_PASSWORD}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_HOST', null);/define('DB_HOST', '${MYSQL_HOST}');/" /var/www/localhost/htdocs/wp-config.php

echo "Starting all process ..."
exec httpd -DFOREGROUND
