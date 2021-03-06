#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${WEB_PASSWORD}x" == "x" ]; then
    echo "WEB_PASSWORD is missing"
    exit 1
fi

/usr/sbin/update-ca-certificates

WEB_PASSWORD_ENCRYPTED="$(/usr/bin/mkpasswd -m sha-512 ${WEB_PASSWORD})"

sed -i "s/user admin password.*/user admin password ${WEB_PASSWORD_ENCRYPTED//\//\\/}/" /etc/haproxy/haproxy.cfg
sed -i "s/MYHOSTNAME/${MYHOSTNAME}/" /etc/haproxy/haproxy-ssl.cfg

if [ -f /certs/live/${MYHOSTNAME}/fullchain.pem ] && [ -f /certs/live/${MYHOSTNAME}/privkey.pem ]; then
	echo "* SSL certificate data found"
	cat /certs/live/${MYHOSTNAME}/fullchain.pem /certs/live/${MYHOSTNAME}/privkey.pem > /${MYHOSTNAME}.pem	
	export ENABLE_SSL="-f /etc/haproxy/haproxy-ssl.cfg"
else
	export ENABLE_SSL=""
	echo "* SSL certificate data missing"
fi

test -d /var/run/supervisord || mkdir -p /var/run/supervisord

supervisord -n -c /etc/supervisord.conf

