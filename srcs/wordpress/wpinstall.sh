#!/bin/sh
cd /www
wp core is-installed
if [ $? == 1 ]; then
    echo "wp core is-installed has exit status 1"
    wp core download
    wp core install --url=wordpress/ --path=/www --title="Peers insane mooie site" --admin_user="peer" --admin_password="pass" --admin_email=pde-bakk@student.codam.nl --skip-email
    :> /tmp/postid
    wp term create category Memes
    wp post create --post_author=Peer --post_category="Memes" --post-title="They hated him because He told them the truth" --post-content="fmlorem ipsum" --post_excerpt=tag --post_status=publish | awk '{gsub(/[.]/, ""); print $4}' > /tmp/postid
    echo -n "created a post with id: "; cat /tmp/postid; echo ""
    wp media import ft_services.jpg --title=fuckft_services --post_id=$(cat /tmp/postid) --featured_image

    wp user create eddy editor@example.com --role=editor --user_pass=editor
    wp user create autist author@example.com --role=author --user_pass=author
    wp user create contenbonker contributor@example.com --role=contributor --user_pass=contributor
    wp user create simp subscriber@example.com --role=subscriber --user_pass=subscriber

    wp theme install winter
    wp theme install twentyten
    wp theme install twentytwenty
    wp theme activate winter
    wp plugin install woocommerce
else
    echo "wp core is-installed has exit status NOT 1"
    echo "Wordpress was already installed in the /www directory"
fi
