FROM alpine:3.7

LABEL MAINTAINER "Aurelien PERRIER <a.perrier89@gmail.com>"
LABEL APP "wordpress"
LABEL APP_REPOSITORY "https://github.com/WordPress/WordPress/releases"

ENV TIMEZONE Europe/Paris
ENV VERSION_WORDPRESS 4.9.6
ENV APACHE_SERVER_NAME example.com
ENV APACHE_SERVER_PATH /var/www/localhost/htdocs
ENV MYSQL_DATABASE app
ENV MYSQL_USER app
ENV MYSQL_PASSWORD app
ENV MYSQL_HOST mysql

# Installing dependencies
RUN apk add --no-cache --virtual .build-deps unzip
RUN apk add --no-cache apache2 php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib su-exec
RUN mkdir -p /run/apache2 /run/httpd

# Work path
WORKDIR /scripts

# Download & install wordpress
ADD https://wordpress.org/wordpress-${VERSION_WORDPRESS}.zip ./
RUN unzip -q wordpress-${VERSION_WORDPRESS}.zip -d ./ && \
        rm -rf ${APACHE_SERVER_PATH} && \
        mv wordpress/ ${APACHE_SERVER_PATH} && \
        rm /scripts/wordpress-${VERSION_WORDPRESS}.zip \
            ${APACHE_SERVER_PATH}/wp-config-sample.php \
            ${APACHE_SERVER_PATH}/license.txt \
            ${APACHE_SERVER_PATH}/readme.html && \
        chown -R apache:apache ${APACHE_SERVER_PATH} && \
        apk del .build-deps

# Copy of the HTTPD startup script
COPY ./scripts/start.sh ./start.sh
COPY ./wp-config-tmp.php ${APACHE_SERVER_PATH}/wp-config.php

EXPOSE 80
