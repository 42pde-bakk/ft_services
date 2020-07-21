#!/bin/sh

mkdir -p /var/run/nginx

adduser --disabled-password ${SSH_USERNAME}
echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
echo "user = ${SSH_USERNAME} pass = ${SSH_PASSWORD}"