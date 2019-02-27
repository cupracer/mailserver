FROM opensuse/leap:15.0

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

EXPOSE 80
CMD ["/start.sh"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends

# no php7-imap package for PHP 7.2 available in openSUSE Leap 15.0 (2018-07-11), so PHP 7.1 needs to be used:

ENV PHP_REPO_ALIAS devel_languages_php_php71

RUN zypper --non-interactive --gpg-auto-import-keys ar --refresh --name $PHP_REPO_ALIAS https://download.opensuse.org/repositories/devel:/languages:/php:/php71/openSUSE_Leap_15.0/devel:languages:php:php71.repo \
	&& zypper --non-interactive --gpg-auto-import-keys ref \
	&& zypper --non-interactive in --no-recommends --from $PHP_REPO_ALIAS \
		php7-openssl \
		php7-phar

RUN zypper --non-interactive in --no-recommends \
		postfixadmin

RUN zypper clean -a

RUN ln -sf /dev/stdout /var/log/apache2/access_log \
	&& ln -sf /dev/stderr /var/log/apache2/error_log

RUN /usr/sbin/a2enmod php7
RUN /usr/sbin/a2enmod remoteip
RUN /usr/sbin/a2enmod logio

RUN /usr/sbin/a2enflag POSTFIXADMIN

COPY target/etc/apache2/conf.d/https.conf /etc/apache2/conf.d/https.conf
COPY target/etc/apache2/conf.d/logging.conf /etc/apache2/conf.d/logging.conf
COPY target/etc/apache2/conf.d/remoteip.conf /etc/apache2/conf.d/remoteip.conf
COPY target/etc/apache2/trusted-proxies.txt /etc/apache2/trusted-proxies.txt

COPY target/etc/postfixadmin/config.local.php /etc/postfixadmin/config.local.php
COPY target/usr/local/bin/setuppass.php /usr/local/bin/setuppass.php
COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

