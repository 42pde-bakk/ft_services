FROM		alpine

# mariadb is a mysql database.
RUN			apk add mysql mysql-client

COPY		startup.sh /tmp/startup.sh
# RUN         cp /etc/my.cnf /tmp/
COPY        my.cnf /etc/
VOLUME		/var/lib/mysql

ENTRYPOINT	["/bin/sh", "/tmp/startup.sh"]
