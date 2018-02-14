#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
	echo "MYSQL_PASSWORD is missing"
	exit 1
fi

DES_KEY="$(/usr/bin/pwgen -1cay 24)"

sed -i "s/.*config.*db_dsnw.*/\$config\[\'db_dsnw\'\] = \'mysql\:\/\/app\:${MYSQL_PASSWORD//\//\\/}@roundcube-mysql\/app\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*smtp_server.*/\$config\[\'smtp_server\'\] = \'tls:\/\/${MYHOSTNAME//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*default_host.*/\$config\[\'default_host\'\] = \'tls:\/\/${MYHOSTNAME//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php
sed -i "s/.*config.*des_key.*/\$config\[\'des_key\'\] = \'${DES_KEY//\//\\/}\'\;/" /etc/roundcubemail/config.inc.php

/usr/sbin/start_apache2 -DFOREGROUND -k start
