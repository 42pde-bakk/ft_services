FROM alpine:latest

RUN apk update \
    && apk add curl

RUN mkdir /etc/telegraf \
    && wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz \
    && tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz \
    && chmod +x telegraf/* \
    && cp telegraf/telegraf /usr/bin/ \
    && rm -rf telegraf-1.13.3-static_linux_amd64.tar.gz telegraf/

COPY telegraf.conf /etc/telegraf/telegraf.conf

COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 8125

CMD ./setup.sh
