FROM alpine:latest

WORKDIR /usr/share/grafana

RUN apk update && \
    apk add bash curl wget && \
    apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY datasource/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/

RUN mkdir /usr/share/grafana/conf/provisioning/dashboards/mine
COPY dashboards/*.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY dashboards/sample.yaml /usr/share/grafana/conf/provisioning/dashboards/

EXPOSE 3000

ENTRYPOINT [ "/usr/sbin/grafana-server", "web" ]
