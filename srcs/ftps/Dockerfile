FROM alpine:latest
# IP is a build-time variable.
# This means once this dockerfile is done building, IP isnt accessible anymore
ARG	IP

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN		apk update && \
		apk add openrc && \
		apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache && \
		apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Let's create a new user
RUN	{ echo "password"; echo "password";} | adduser user

# Saving the minikube IP
RUN	echo ${IP} > ip.txt

# Setting up the Telegraf config
# Fuck telegraf, all my homies hate telegraf
RUN	mkdir - /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

# A nice lil welcome message:
RUN	echo 'FTP of ft_services by Peer' > /hello.txt

# https://i.imgur.com/TxkzN48.jpg
COPY ./start.sh /start.sh
CMD sh /start.sh
EXPOSE 21 21000
