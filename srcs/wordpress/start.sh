curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chown -R www:www /var/lib/nginx
chown -R www:www /www

cp /tmp/wp-config.php /www/wp-config.php
cp /tmp/ft_services.jpg /www/ft_services.jpg

envsubst '${WORDPRESS_SVC_SERVICE_HOST} ${WORDPRESS_SVC_SERVICE_PORT} ${DB_NAME} ${DB_USER} ${DB_PASS} ${DB_HOST}' < /tmp/wp-config.php > /www/wp-config.php
rm /tmp/wp-config.php
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /www
su -c "/tmp/wpinstall.sh" - www
rm -rf /root/.wp-cli

