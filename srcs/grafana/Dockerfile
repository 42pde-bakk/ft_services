FROM alpine:latest

WORKDIR /usr/share/grafana

RUN apk update && \
    apk add bash curl wget && \
    apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

# RUN apk update && apk add --no-cache --upgrade bash \
# && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

# RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
# && tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
# && rm -rf /var/cache/apk/* 	
# && rm /grafana-6.6.0/conf/defaults.ini \

# COPY ./defaults.ini ./grafana-6.6.0/conf/
COPY datasource/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/
RUN mkdir /usr/share/grafana/conf/provisioning/dashboards/mine
COPY dashboards/*.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY dashboards/sample.yaml /usr/share/grafana/conf/provisioning/dashboards/
# COPY datasource/grafana.db /usr/share/grafana/data/grafana.db
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh


EXPOSE 3000

# CMD ./setup.sh
ENTRYPOINT [ "/usr/sbin/grafana-server", "web" ]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
