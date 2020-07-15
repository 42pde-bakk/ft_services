FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
&& tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
&& rm /grafana-6.6.0/conf/defaults.ini \
&& rm -rf /var/cache/apk/* 	

# COPY ./defaults.ini ./grafana-6.6.0/conf/
# COPY ./grafana.db ./grafana-6.6.0/data/
COPY setup.sh .

RUN chmod +x setup.sh

EXPOSE 3000

CMD ./setup.sh
