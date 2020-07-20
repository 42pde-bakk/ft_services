FROM alpine:latest

RUN apk upgrade
RUN apk add openssl vsftpd
RUN apk add jq curl
ENV API_URL=https://kubernetes
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=Noord-Holland/O=Codam/CN=Peer de Bakker' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
RUN mkdir -p /var/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
RUN mkdir /peer

EXPOSE 20 21 30000

ENTRYPOINT ["/tmp/setup.sh"]
