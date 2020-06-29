FROM alpine:latest

RUN apk update \
    && apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php7-zip \
    && mkdir www

# Install phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz \
	&& tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /www \
	&& mkdir /www/tmp \
	&& chmod 777 /www/tmp

COPY config.inc.php /www

COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 5000

CMD ./setup.sh