#!/bin/bash

test -d /var/run/rspamd || mkdir -p /var/run/rspamd

/usr/bin/rspamd -c /etc/rspamd/rspamd.conf -f -u vmail -g vmail

