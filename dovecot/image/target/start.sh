#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
	echo "MYSQL_PASSWORD is missing"
	exit 1
fi

sed -i "s/^connect =.*/connect = host=mysql dbname=app user=app password=${MYSQL_PASSWORD//\//\\/}/" /etc/dovecot/dovecot-sql.conf.ext
sed -i "s/^connect =.*/connect = host=mysql dbname=app user=app password=${MYSQL_PASSWORD//\//\\/}/" /etc/dovecot/dovecot-dict-sql.conf.ext

sed -i "s/postmaster_address = postmaster@postfix/postmaster_address = postmaster@${MYHOSTNAME}/" /etc/dovecot/conf.d/20-lmtp.conf
sed -i "s/MYHOSTNAME/${MYHOSTNAME}/g" /etc/dovecot/conf.d/10-ssl.conf

while ! [[ -f /certs/${MYHOSTNAME}/fullchain.pem ]] || ! [[ -f /certs/${MYHOSTNAME}/privkey.pem ]]; do echo "waiting for SSL certificate data"; sleep 1; done

dovecot -F

