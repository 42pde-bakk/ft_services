FROM alpine:3.11.6

RUN apk add --no-cache mysql mysql-client
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
