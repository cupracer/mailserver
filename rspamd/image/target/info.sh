if [ "${RSPAMD_USE_DKIM}" == "true" ];
then
    if [ "${RSPAMD_DKIM_NAME}x" == "x" ]; then
        echo "RSPAMD_DKIM_NAME is missing"
        exit 1
    fi

    if ! test -f /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.key; then
        echo "DKIM key is missing"
        exit 1
    fi

    echo "= DKIM ============================================="
    cat /usr/local/etc/dkim/${RSPAMD_DKIM_NAME}.txt
    echo "= DKIM END ========================================="
else
	echo "RSPAMD_USE_DKIM is not enabled"
	exit 1
fi

