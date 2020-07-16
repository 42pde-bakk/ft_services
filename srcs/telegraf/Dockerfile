FROM alpine:latest
ARG INCOMING
ENV MINIKUBE_IP=${INCOMING}
# Install telegraf for monitoring
RUN mkdir /etc/telegraf \
&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz \
&& tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz \
&& chmod +x telegraf/* \
&& cp telegraf/telegraf /usr/bin/ \
&& rm -rf *.tar.gz* telegraf/ \
&& rm -rf /var/cache/apk/*

RUN apk add curl nano gettext
COPY defaulttelegraf.conf /etc/telegraf/telegraf.conf
COPY setup.sh .

RUN chmod +x setup.sh

EXPOSE 4999

CMD ./setup.sh
