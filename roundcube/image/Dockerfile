FROM opensuse/leap:15.0

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 80
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
	&& zypper --non-interactive in --no-recommends \
		curl \
	&& rpm --import https://download.opensuse.org/repositories/server:/php:/applications/openSUSE_Leap_15.0/repodata/repomd.xml.key \
	&& zypper ar --refresh https://download.opensuse.org/repositories/server:/php:/applications/openSUSE_Leap_15.0/server:php:applications.repo \
	&& zypper --non-interactive ref \
	&& zypper --non-interactive in --no-recommends \
		netcat-openbsd \
		php5-fileinfo \
		php5-intl \
		php5-zip \
		pwgen \
		roundcubemail \
	&& zypper clean -a

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

RUN /usr/sbin/a2enmod php5
RUN /usr/sbin/a2enmod remoteip
RUN /usr/sbin/a2enmod logio

COPY target/etc/apache2/conf.d/https.conf /etc/apache2/conf.d/https.conf
COPY target/etc/apache2/conf.d/logging.conf /etc/apache2/conf.d/logging.conf
COPY target/etc/apache2/conf.d/remoteip.conf /etc/apache2/conf.d/remoteip.conf
COPY target/etc/apache2/trusted-proxies.txt /etc/apache2/trusted-proxies.txt

COPY target/etc/roundcubemail/config.inc.php /etc/roundcubemail/config.inc.php
COPY target/etc/roundcubemail/managesieve.inc.php /etc/roundcubemail/managesieve.inc.php

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

