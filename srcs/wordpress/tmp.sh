curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /www
wp core download --allow-root
rm -rf /root/.wp-cli
while :
do
    mysqladmin -h mysql ping
    if [ $? == 0 ]
    then
        break
    fi
    sleep 10
done
echo "Connection with Mysql established."
wp config create --allow-root --dbname=wordpress --dbuser=bpeeters --dbpass=fluffclub --dbhost=mysql --dbcharset=utf8mb4 --extra-php <<PHP
define('WP_HOME', 'http://MINIKUBE_IP:5050' );
define('WP_SITEURL', 'http://MINIKUBE_IP:5050' );
PHP
wp core install --allow-root --url=http://MINIKUBE_IP:5050 --path=/www --title="ft_services" --admin_user=bpeeters --admin_password=fluffclub --admin_email=bpeeters@student.codam.nl --skip-email
wp user create --allow-root editor editor@example.com --role=editor --user_pass=editor
wp user create --allow-root author author@example.com --role=author --user_pass=author
wp user create --allow-root contributor contributor@example.com --role=contributor --user_pass=contributor
wp user create --allow-root subscriber subscriber@example.com --role=subscriber --user_pass=subscriber
chown -R www:www /www
php-fpm7
nginx -g "daemon off;"