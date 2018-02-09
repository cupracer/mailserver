FROM opensuse

MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref && \
	zypper --non-interactive in \
		apache2 \
		certbot \
		curl \
		vim \
		which

RUN zypper --non-interactive up

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

EXPOSE 80

CMD /usr/sbin/start_apache2 -DFOREGROUND -k start
