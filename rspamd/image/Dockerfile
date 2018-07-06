FROM opensuse/leap:15.0

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 11332 11334
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
    && zypper --non-interactive in --no-recommends \
        curl \
	&& rpm --import https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_15.0/repodata/repomd.xml.key \
	&& zypper ar --refresh https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_15.0/server:mail.repo \
	&& zypper --non-interactive ref \
	&& zypper --non-interactive in --no-recommends \
		rspamd \
	&& zypper clean -a

RUN	mkdir -p /usr/local/etc/dkim \
	&& chown -R _rspamd: /usr/local/etc/dkim \
    && chmod -R 770 /usr/local/etc/dkim

COPY target/etc/rspamd/local.d/rspamd.conf.local /etc/rspamd/local.d/rspamd.conf.local
COPY target/etc/rspamd/local.d/worker-controller.inc /etc/rspamd/local.d/worker-controller.inc
COPY target/etc/rspamd/local.d/worker-proxy.inc /etc/rspamd/local.d/worker-proxy.inc
COPY target/etc/rspamd/local.d/logging.inc /etc/rspamd/local.d/logging.inc
COPY target/etc/rspamd/local.d/milter_headers.conf /etc/rspamd/local.d/milter_headers.conf
COPY target/etc/rspamd/local.d/classifier-bayes.conf /etc/rspamd/local.d/classifier-bayes.conf
COPY target/etc/rspamd/local.d/redis.conf /etc/rspamd/local.d/redis.conf
COPY target/etc/rspamd/local.d/statistics.conf /etc/rspamd/local.d/statistics.conf
COPY target/etc/rspamd/local.d/antivirus.conf /etc/rspamd/local.d/antivirus.conf
COPY target/usr/local/src/dkim_signing.conf.tpl /usr/local/src/dkim_signing.conf.tpl 
COPY target/usr/local/src/arc.conf.tpl /usr/local/src/arc.conf.tpl

COPY target/start.sh /start.sh
COPY target/info.sh /usr/local/bin/info.sh

RUN chmod 755 /start.sh /usr/local/bin/info.sh

