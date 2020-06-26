#!/bin/sh

# We launch Telegraf and a simple web server hosting Wordpress
# telegraf &
php -S 0.0.0.0:5050 -t /www/
