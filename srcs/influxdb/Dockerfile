FROM alpine

MAINTAINER Peer de Bakker <pde-bakk@student.codam.nl>
RUN apk update && apk add influxdb

EXPOSE 8806

CMD influxd run
