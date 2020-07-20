FROM alpine

# Fix this error
# nginx: [emerg] open() "/run/nginx/nginx.pid" failed (2: No such file or directory)
# simply by running:
RUN mkdir -p /run/nginx

# We install packages
RUN apk update \
    && apk add wget \
    && apk add curl \
    && apk add gettext

# Install Php
RUN apk add php7-common php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php7-phar php7-cli php7-zip php7-iconv php7-xml php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN apk add nginx

RUN adduser -D -g 'www' www
RUN mkdir /www

COPY wp-config.php /tmp/wp-config.php
COPY wpinstall.sh /tmp/wpinstall.sh
COPY ft_services.jpg /tmp/ft_services.jpg
COPY nginx.conf /etc/nginx/nginx.conf

# RUN     sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;listen.group\s*=\s*nobody|listen.group = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|user\s*=\s*nobody|user = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|group\s*=\s*nobody|group = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf ;

# Here we go again
COPY start.sh /tmp/start.sh
RUN chmod +x /tmp/wpinstall.sh
RUN chmod +x /tmp/start.sh
EXPOSE 5050
CMD ./tmp/start.sh