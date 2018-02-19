FROM opensuse:42.3

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 25 80 143 443 587 993
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
	&& zypper --non-interactive in --no-recommends \
		haproxy \
    	whois \
	&& zypper clean -a

COPY target/etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
COPY target/etc/haproxy/haproxy-ssl.cfg /etc/haproxy/haproxy-ssl.cfg

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

