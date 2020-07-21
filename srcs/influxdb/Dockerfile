FROM alpine:latest

RUN apk update && apk add influxdb && \
    apk add --no-cache --upgrade bash

COPY setup.sh .

RUN chmod +x setup.sh

EXPOSE 8086

CMD ./setup.sh
