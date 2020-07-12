FROM alpine

# We install packages
RUN apk update && apk add wget && mkdir /www && \
    apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php-phar && \
    apk add gettext curl

# We get the last version of Wordpress and uncompress it
# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xvf latest.tar.gz && \
#     mv wordpress/* /www && \
#     rm -rf /var/cache/apk/* wordpress latest.tar.gz

# We copy wordpress database config file
COPY wp-config.php /www/wp-config.php
COPY ft_services.jpg /www/ft_services.jpg

# Here we go
COPY start.sh /tmp/
RUN chmod +x /tmp/start.sh
EXPOSE 80
CMD ./tmp/start.sh