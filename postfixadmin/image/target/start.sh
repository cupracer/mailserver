#!/bin/bash

if [ "${MYHOSTNAME}x" == "x" ]; then
	echo "MYHOSTNAME is missing"
	exit 1
fi

if [ "${MYSQL_PASSWORD}x" == "x" ]; then
        echo "MYSQL_PASSWORD is missing"
        exit 1
fi

sed -i "s/MYHOSTNAME/${MYHOSTNAME}/g" /srv/www/htdocs/postfixadmin/config.local.php
sed -i "s/MYSQL_PASSWORD/${MYSQL_PASSWORD//\//\\/}/g" /srv/www/htdocs/postfixadmin/config.local.php

/usr/sbin/start_apache2 -DFOREGROUND -k start

