#!/bin/sh

cp /www/wp-config.php /tmp/wp-configcopy.php
envsubst '${WORDPRESS_SVC_SERVICE_HOST} ${WORDPRESS_SVC_SERVICE_PORT} ${DB_NAME} ${DB_USER} ${DB_PASS} ${DB_HOST}' < /tmp/wp-configcopy.php > /www/wp-config.php
rm /tmp/wp-configcopy.php

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "start"
rm -rf /root/.wp-cli
echo "real start"
cd /www/
wp core is-installed
echo $?
if ! $(wp core is-installed); then
    echo "start iffi"
    
    wp core download --allow-root
    echo "after core download"
    wp core install --allow-root --url=192.168.99.100:5050 --title="Peers site" --admin_user="peer" --admin_password="pass" --admin_email="pde-bakk@student.codam.nl" --skip-email
    echo "after core install"
    wp post create --post-title="They hated him because He told them the truth" --post-content="fmlorem ipsum" --post_excerpt=tag --post_status=publish | awk '{gsub(/[.]/, ""); print $4}'
    echo "created a post"
    wp media import ft_services.jpg --title=fuckft_services --post_id=$(wp post create --post-title="They hated him because He told them the truth" --post-content="fmlorem ipsum" --post_excerpt=tag --post_status=publish | awk '{gsub(/[.]/, ""); print $4}') --featured_image
    # wp post meta add % _thumbnail_id $ATTACHMENT_ID
    # wp post list --post_type=post --format-ids | xargs -d ' ' -I % wp post meta add % _thumbnail_id $ATTACHMENT_ID
    # echo "after posting the truth"
    wp user create editor editor@peer.codam --role=editor --user_pass=editor
    wp user create author author@peer.codam --role=author --user_pass=author
    wp user create hackerman hackerman@peer.codam --role=contributor --user_pass=mrrobot
    wp user create simp simp@peer.codam --role=subscriber --user_pass=pokimane
    echo "after creating simps"
fi
echo "after iffi"
wp theme install winter > /dev/null
wp theme install twentyten > /dev/null
wp theme install twentytwenty > /dev/null
# wp theme activate winter > /dev/null


wp plugin install woocommerce > /dev/null
wp plugin install woocommerce > /dev/null
cd /
php -S 0.0.0.0:80 -t /www/