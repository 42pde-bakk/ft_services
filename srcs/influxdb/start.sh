#!/bin/bash

# Launching telegraf and InfluxDB
telegraf &
influxdb run -config /etc/influxdb.conf
