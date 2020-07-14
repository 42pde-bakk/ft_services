#!/bin/sh
cp /etc/telegraf/telegraf.conf /etc/telegraf/tmptelegraf.conf
envsubst '${MINIKUBEIP}' < /etc/telegraf/tmptelegraf.conf > /etc/telegraf/telegraf.conf
while :
do
    curl http://influxdb:8086/ping
    if [ $? == 0 ]
    then
        break
    fi
    echo "Connection not up yet"
    sleep 5
done
echo "Connection with InfluxDB established."
telegraf -config /etc/telegraf/telegraf.conf
