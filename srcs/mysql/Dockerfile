FROM alpine

RUN	apk add mysql mysql-client

COPY startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh
COPY my.cnf /etc/
VOLUME /var/lib/mysql

ENTRYPOINT ["/bin/sh", "/tmp/startup.sh"]
