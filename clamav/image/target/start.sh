#!/bin/bash

/usr/sbin/update-ca-certificates

/usr/bin/freshclam -d 

while true; do
	/usr/sbin/clamd
	echo "ClamAV not running!"
	sleep 3
	echo "ClamAV restarting..."
done

