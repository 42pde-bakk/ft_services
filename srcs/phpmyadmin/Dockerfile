FROM alpine:latest

RUN apk update && \
    apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php7-zip && \
    mkdir -p /www/tmp && \
	apk add wget curl nginx gettext

RUN mkdir -p /run/nginx
# Install phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /www && \
	chmod 777 /www/tmp

RUN adduser -D -g 'www' www

COPY config.inc.php /www
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx.conf

# RUN     sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;listen.group\s*=\s*nobody|listen.group = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|user\s*=\s*nobody|user = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|group\s*=\s*nobody|group = www|g" /etc/php7/php-fpm.d/www.conf ;\
#         sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf ;

COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 5000

CMD ./setup.sh