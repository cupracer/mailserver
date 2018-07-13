FROM opensuse/leap:15.0

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 25 80 143 443 587 993
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
	&& zypper --non-interactive in --no-recommends \
		haproxy \
		rsyslog \
    	whois

RUN zypper --non-interactive --gpg-auto-import-keys ar --refresh https://download.opensuse.org/repositories/Cloud:/OpenStack:/Master/openSUSE_Leap_15.0/Cloud:OpenStack:Master.repo \
	&& zypper --non-interactive --gpg-auto-import-keys ref \
	&& zypper --non-interactive in --no-recommends \
		python-setuptools \
		python-supervisor

RUN zypper clean -a

COPY target/etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
COPY target/etc/haproxy/haproxy-ssl.cfg /etc/haproxy/haproxy-ssl.cfg
COPY target/etc/supervisord.conf /etc/supervisord.conf
COPY target/etc/rsyslog.conf /etc/rsyslog.conf
COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

