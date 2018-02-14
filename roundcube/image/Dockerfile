FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
	&& zypper --non-interactive in \
		php5-fileinfo \
		php5-intl \
		php5-zip \
		pwgen \
		roundcubemail

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

RUN /usr/sbin/a2enmod php5

COPY target/etc/roundcubemail/config.inc.php /etc/roundcubemail/config.inc.php
COPY target/etc/roundcubemail/managesieve.inc.php /etc/roundcubemail/managesieve.inc.php

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

EXPOSE 80

CMD ["/start.sh"]

