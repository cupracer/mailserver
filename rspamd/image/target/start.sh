#!/bin/bash

if [ "${RSPAMD_WEB_PASSWORD}x" == "x" ]; then
	echo "RSPAMD_WEB_PASSWORD is missing"
	exit 1
fi

test -d /var/run/rspamd || mkdir -p /var/run/rspamd

RSPAMD_WEB_PASSWORD_ENCRYPTED=$(/usr/bin/rspamadm pw -q -p "${RSPAMD_WEB_PASSWORD}");

if [ $? -ne 0 ]; then
	echo "could not generate web password. aborting."
else
	sed -i "s/^password =.*/password = \"${RSPAMD_WEB_PASSWORD_ENCRYPTED}\"/" /etc/rspamd/local.d/worker-controller.inc
fi

/usr/bin/rspamd -c /etc/rspamd/rspamd.conf -f -u vmail -g vmail

