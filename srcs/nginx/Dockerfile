FROM alpine:latest

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN apk update \
	&& apk add nginx \
	&& apk add openssl

RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www


# RUN addgroup sshgroup \
# 	&& adduser -D peer \
# 	&& echo "peer:damsko" | chpasswd \
# 	&& ssh-keygen -A
	
#SSH
COPY sshd_config /etc/ssh/sshd_config

# SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=Noord-Holland/O=Codam/CN=services' -keyout /etc/ssl/services.key -out /etc/ssl/services.crt

COPY nginx.conf /etc/nginx/
COPY homepage-pde-bakk/* /www/

EXPOSE 80 443 22000 

CMD ["nginx", "-g", "daemon off;"]
