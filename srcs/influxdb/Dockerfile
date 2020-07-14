FROM alpine:latest

RUN apk update && apk add influxdb gettext curl nano

RUN cp /etc/influxdb.conf /tmp/
COPY influxdb.conf /etc/influxdb.conf

COPY setup.sh .
RUN chmod +x setup.sh

VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

CMD ./setup.sh
