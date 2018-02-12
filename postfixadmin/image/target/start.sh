#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
	echo "MYSQL_PASSWORD is missing"
	exit 1
fi

if [ "${SETUP_PASSWORD}x" == "x" ]; then
	echo "SETUP_PASSWORD is missing"
	exit 1
fi

sed -i "s/MYHOSTNAME/${MYHOSTNAME}/g" /srv/www/htdocs/postfixadmin/config.local.php
sed -i "s/MYSQL_PASSWORD/${MYSQL_PASSWORD//\//\\/}/g" /srv/www/htdocs/postfixadmin/config.local.php

SETUP_PASSWORD_ENCRYPTED=$(php /usr/local/bin/setuppass.php "${SETUP_PASSWORD}");

if [ $? -ne 0 ]; then
	echo "could not generate setup password. aborting."
else 
	echo "\$CONF['setup_password'] = '${SETUP_PASSWORD_ENCRYPTED}';" >> /srv/www/htdocs/postfixadmin/config.local.php
fi

/usr/sbin/start_apache2 -DFOREGROUND -k start

