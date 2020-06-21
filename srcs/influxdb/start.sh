#!/bin/bash

# Launching telegraf and InfluxDB
telegraf &
influxd run -config /etc/influxdb.conf
