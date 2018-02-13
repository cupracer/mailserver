FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
    && zypper --non-interactive in \
        curl \
	&& rpm --import https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_42.3/repodata/repomd.xml.key \
	&& zypper ar --refresh https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_42.3/server:mail.repo \
	&& zypper --non-interactive ref \
	&& zypper --non-interactive in \
		rspamd

RUN groupadd -r vmail \
	&& useradd -g vmail -m -s /bin/false vmail

COPY target/etc/rspamd/local.d/rspamd.conf.local /etc/rspamd/local.d/rspamd.conf.local
COPY target/etc/rspamd/local.d/worker-controller.inc /etc/rspamd/local.d/worker-controller.inc
COPY target/etc/rspamd/local.d/worker-proxy.inc /etc/rspamd/local.d/worker-proxy.inc
COPY target/etc/rspamd/local.d/logging.inc /etc/rspamd/local.d/logging.inc
COPY target/etc/rspamd/local.d/milter_headers.conf /etc/rspamd/local.d/milter_headers.conf
COPY target/etc/rspamd/local.d/classifier-bayes.conf /etc/rspamd/local.d/classifier-bayes.conf
COPY target/etc/rspamd/local.d/redis.conf /etc/rspamd/local.d/redis.conf
COPY target/etc/rspamd/local.d/statistics.conf /etc/rspamd/local.d/statistics.conf
COPY target/etc/rspamd/local.d/antivirus.conf /etc/rspamd/local.d/antivirus.conf

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

EXPOSE 11332 11334

CMD ["/start.sh"]

