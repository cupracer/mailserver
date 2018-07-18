#!/bin/bash

if [ "${SMTP_SERVER}x" == "x" ]; then
	echo "SMTP_SERVER is missing"
	exit 1
fi

if [ "${IMAP_SERVER}x" == "x" ]; then
	echo "IMAP_SERVER is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
	echo "MYSQL_PASSWORD is missing"
	exit 1
fi

/usr/sbin/update-ca-certificates

DES_KEY="$(/usr/bin/pwgen -1cay 24)"

sed -i "s/.*config.*db_dsnw.*/\$config\[\'db_dsnw\'\] = \'mysql\:\/\/app\:${MYSQL_PASSWORD//\//\\/}@roundcube-mysql\/app\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*smtp_server.*/\$config\[\'smtp_server\'\] = \'tls:\/\/${SMTP_SERVER//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*default_host.*/\$config\[\'default_host\'\] = \'tls:\/\/${IMAP_SERVER//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*des_key.*/\$config\[\'des_key\'\] = \'${DES_KEY//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php

until nc -z roundcube-mysql 3306
do
	echo "waiting for DB"
	sleep 3
done

echo "* running initdb.sh" && /srv/www/roundcubemail/bin/initdb.sh --dir /srv/www/roundcubemail/SQL
echo "* running updatedb.sh" && /srv/www/roundcubemail/bin/updatedb.sh --dir /srv/www/roundcubemail/SQL --package roundcube

/usr/sbin/start_apache2 -DFOREGROUND -k start
