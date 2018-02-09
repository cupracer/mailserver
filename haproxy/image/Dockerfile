FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref && \
    zypper --non-interactive in \
        curl

RUN zypper --non-interactive up

RUN zypper --non-interactive in \
	haproxy \
	vim \
	which \
    whois

COPY target/etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

CMD ["/start.sh"]

