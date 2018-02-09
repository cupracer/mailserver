#!/bin/bash

if [ "${WEB_PASSWORD}x" == "x" ]; then
    echo "WEB_PASSWORD is missing"
    exit 1
fi

WEB_PASSWORD_ENCRYPTED="$(/usr/bin/mkpasswd -m sha-512 ${WEB_PASSWORD})"

sed -i "s/user admin password.*/user admin password ${WEB_PASSWORD_ENCRYPTED//\//\\/}/" /etc/haproxy/haproxy.cfg

/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -db

