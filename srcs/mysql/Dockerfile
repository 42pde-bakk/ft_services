FROM alpine:latest

RUN apk update \
    && apk add --no-cache mysql
    
RUN addgroup mysql mysql

COPY setup.sh .
COPY my.cnf /etc/mysql/my.cnf

VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306
ENTRYPOINT [ "./setup.sh" ]