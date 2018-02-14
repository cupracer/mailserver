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

if [ "${RSPAMD_USE_DKIM}" == "true" ]; then

	if [ "${RSPAMD_DKIM_NAME}x" == "x" ]; then
		echo "RSPAMD_DKIM_NAME is missing"
		exit 1
	fi

	if ! test -f /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.key; then
		echo "generating new DKIM key"
		rspamadm dkim_keygen -b 2048 -s ${RSPAMD_DKIM_NAME} -k /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.key > /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.txt
	fi

	chown -R _rspamd:_rspamd /usr/local/etc/dkim
	chmod 440 /usr/local/etc/dkim/*

	if ! test -f /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.key; then
		echo "DKIM key is missing"
		exit 1
	fi

	echo "= DKIM ============================================="
	cat /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.txt
	echo "= DKIM END ========================================="

	cat /usr/local/src/dkim_signing.conf.tpl | sed -e "s/RSPAMD_DKIM_NAME/${RSPAMD_DKIM_NAME}/" > /etc/rspamd/local.d/dkim_signing.conf

	if [ "${RSPAMD_USE_DMARC}" == "true" ]; then
		cat /usr/local/src/arc.conf.tpl | sed -e "s/RSPAMD_DKIM_NAME/${RSPAMD_DKIM_NAME}/" > /etc/rspamd/local.d/arc.conf
	fi
fi

/usr/bin/rspamd -c /etc/rspamd/rspamd.conf -f -u _rspamd -g _rspamd

