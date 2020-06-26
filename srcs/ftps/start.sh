#!/bin/sh
cat ip.txt
telegraf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
