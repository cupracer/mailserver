#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
	echo "MYSQL_PASSWORD is missing"
	exit 1
fi

if [ "${RSPAMD_WEB_PASSWORD}x" == "x" ]; then
	echo "RSPAMD_WEB_PASSWORD is missing"
	exit 1
fi

sed -i "s/^connect =.*/connect = host=mysql dbname=app user=app password=${MYSQL_PASSWORD//\//\\/}/" /etc/dovecot/dovecot-sql.conf.ext
sed -i "s/^connect =.*/connect = host=mysql dbname=app user=app password=${MYSQL_PASSWORD//\//\\/}/" /etc/dovecot/dovecot-dict-sql.conf.ext

sed -i "s/postmaster_address = postmaster@postfix/postmaster_address = postmaster@${MYHOSTNAME}/" /etc/dovecot/conf.d/20-lmtp.conf
sed -i "s/MYHOSTNAME/${MYHOSTNAME}/g" /etc/dovecot/conf.d/10-ssl.conf

sed -i "s/RSPAMD_WEB_PASSWORD/${RSPAMD_WEB_PASSWORD//\//\\/}/" /usr/local/bin/rspamc-learn.sh

while ! [[ -f /certs/live/${MYHOSTNAME}/fullchain.pem ]] || ! [[ -f /certs/live/${MYHOSTNAME}/privkey.pem ]]; do echo "waiting for SSL certificate data"; sleep 1; done

test -f /certs/live/${MYHOSTNAME}/ca.crt && cp /certs/live/${MYHOSTNAME}/ca.crt /etc/pki/trust/anchors/${MYHOSTNAME}_ca.crt && update-ca-certificates

test -d /var/run/dovecot/sieve-pipe || mkdir -p /var/run/dovecot/sieve-pipe

dovecot -F

