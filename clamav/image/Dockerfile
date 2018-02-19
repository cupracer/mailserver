FROM opensuse:42.3

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 3310
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
	&& zypper --non-interactive in --no-recommends \
	clamav \
	&& zypper clean -a

COPY target/etc/clamd.conf /etc/clamd.conf
COPY target/etc/freshclam.conf /etc/freshclam.conf

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

