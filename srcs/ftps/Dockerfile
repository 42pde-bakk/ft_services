FROM alpine:latest

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>

RUN		apk add vsftpd

COPY	start_vsftpd.sh /bin/start_vsftpd.sh
COPY	vsftpd.conf /etc/vsftpd/vsftpd.conf
EXPOSE	21

ENTRYPOINT ["/bin/start_vsftpd.sh"]
