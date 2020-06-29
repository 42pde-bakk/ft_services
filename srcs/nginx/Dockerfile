FROM alpine:latest

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN apk update && \
	apk add nginx && \
	apk add openssl && \
	apk add openssh && \
	apk add tar

RUN adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	mkdir -p /run/nginx

# Creating SSH user and SSL key
RUN	adduser -D user
RUN	echo "user:password"|chpasswd
# RUN ssh-keygen -A
# RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=Noord-Holland/O=Codam/CN=ft_services'  -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt

COPY nginx.conf /etc/nginx/
COPY homepage-pde-bakk/ /www/.

EXPOSE 80 443 22

CMD ["nginx", "-g", "daemon off;"]
