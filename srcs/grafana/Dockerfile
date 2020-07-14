FROM alpine:latest

RUN apk update \
    && apk add libc6-compat \
    && apk add curl gettext curl

RUN wget https://dl.grafana.com/oss/release/grafana-6.7.2.linux-amd64.tar.gz \
    && tar -xzvf grafana-6.7.2.linux-amd64.tar.gz \
    && rm grafana-6.7.2.linux-amd64.tar.gz

# COPY grafana.db ./grafana-6.7.2/data/

COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 3000

CMD ./setup.sh
