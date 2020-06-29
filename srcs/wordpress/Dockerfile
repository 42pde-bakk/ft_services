FROM alpine:latest

ENV PHP_FPM_USER="www"
ENV PHP_FPM_GROUP="www"
ENV PHP_FPM_LISTEN_MODE="0660"

RUN apk update \
    && apk add wget \
    && apk add curl \
    && apk add php7-common \
    php7-fpm \
    php7-opcache \
    php7-gd \
    php7-mysqli \
    php7-zlib \
    php7-curl \
    php7-mbstring \
    php7-json \
    php7-session \
    php7-phar \
    php7-cli \
    php7-zip \
    php7-iconv \
    php7-xml \
    php7-imap \
    php7-cgi \
    fcgi \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom \
    nginx \
    mysql-client \
    && rm -rf /var/cache/apk/*

RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

COPY setup.sh .
RUN chmod +x setup.sh

RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf ;\
    sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini ;\
    sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 50M/g" /etc/php7/php.ini ;\
    sed -i "s/max_file_uploads = 20/max_file_uploads = 200/g" /etc/php7/php.ini ;\
    sed -i "s/post_max_size = 8M/post_max_size = 100M/g" /etc/php7/php.ini ;\
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0/g" /etc/php7/php.ini

COPY nginx.conf /etc/nginx

EXPOSE 5050

CMD ./setup.sh
