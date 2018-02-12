FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
	&& zypper --non-interactive in \
		php7-imap \
		postfixadmin

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

RUN /usr/sbin/a2enmod php7

COPY target/srv/www/htdocs/postfixadmin/config.local.php /srv/www/htdocs/postfixadmin/config.local.php
COPY target/usr/local/bin/setuppass.php /usr/local/bin/setuppass.php
COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

EXPOSE 80

CMD ["/start.sh"]

