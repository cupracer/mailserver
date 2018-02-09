FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref && \
    zypper --non-interactive in \
        curl

RUN zypper --non-interactive up

RUN zypper --non-interactive in \
	php5-fileinfo \
	php5-intl \
        php5-zip \
	roundcubemail \
	vim \
	which

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

RUN /usr/sbin/a2enmod php5

COPY target/etc/roundcubemail/config.inc.php /etc/roundcubemail/config.inc.php
COPY target/etc/roundcubemail/managesieve.inc.php /etc/roundcubemail/managesieve.inc.php

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

CMD ["/start.sh"]

