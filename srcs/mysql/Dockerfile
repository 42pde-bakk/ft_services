FROM alpine:3.11.6

RUN apk update
RUN apk add mysql mysql-client
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
