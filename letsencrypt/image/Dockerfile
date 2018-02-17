FROM opensuse

MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
    && zypper --non-interactive up \
	&& zypper --non-interactive in \
		certbot \
		cron \
		python-docker-py

COPY target/etc/certbot/cli.ini /etc/certbot/cli.ini
COPY target/usr/local/sbin/restart-containers.py /usr/local/sbin/restart-containers.py
COPY target/var/spool/cron/tabs/root /var/spool/cron/tabs/root

RUN chmod 755 /usr/local/sbin/restart-containers.py \
	&& chmod 600 /var/spool/cron/tabs/root

EXPOSE 80

CMD /usr/sbin/cron -n -x bit

