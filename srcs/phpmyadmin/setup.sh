chown -R www:www /var/lib/nginx
chown -R www:www /www

php-fpm7
# php -S 0.0.0.0:80 -t /www/
nginx -g "daemon off;"
