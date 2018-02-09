FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref && \
    zypper --non-interactive in \
        curl

RUN zypper --non-interactive up

RUN zypper --non-interactive in \
	clamav \
	vim \
	which

COPY target/etc/clamd.conf /etc/clamd.conf
COPY target/etc/freshclam.conf /etc/freshclam.conf

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

CMD ["/start.sh"]

