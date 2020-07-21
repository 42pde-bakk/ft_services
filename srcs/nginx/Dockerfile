FROM alpine:latest

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN apk update && \
	apk add nginx && \
	apk add openssl && \
	apk add openssh && \
	apk add tar && \
	apk add curl && \
	apk add gettext && \
	apk add nano emacs


RUN adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	mkdir -p /run/nginx

RUN	adduser -D user
RUN	echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=Noord-Holland/O=Codam/CN=Peer de Bakker' -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt

COPY homepage-pde-bakk/ /var/www/localhost/htdocs/.

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY sshd_config /etc/ssh/sshd_config

# Make sure that our ssh daemon keeps restarting
RUN	apk add supervisor
COPY supervisord.conf /etc/supervisord.conf

COPY setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

EXPOSE 80 443 22

CMD ["sh", "-c", "/tmp/setup.sh ; /usr/bin/supervisord -c /etc/supervisord.conf"]
