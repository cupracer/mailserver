FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
    && zypper --non-interactive in \
        curl \
	&& rpm --import https://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Leap_42.3/repodata/repomd.xml.key \
	&& zypper ar --refresh https://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Leap_42.3/devel:languages:python.repo \
	&& zypper --non-interactive ref \
	&& zypper --non-interactive in \
		postfix \
		postfix-mysql \
		rsyslog \
		supervisor

COPY target/etc/supervisord.conf /etc/supervisord.conf
COPY target/start.sh /start.sh
COPY target/postfix-wrapper.sh /usr/local/bin/postfix-wrapper.sh

RUN chmod 755 /start.sh /usr/local/bin/postfix-wrapper.sh
RUN mkdir /var/run/supervisord

COPY target/etc/rsyslog.conf /etc/rsyslog.conf
COPY target/etc/postfix/main.cf /etc/postfix/main.cf
COPY target/etc/postfix/master.cf /etc/postfix/master.cf

COPY target/etc/postfix/without_ptr /etc/postfix/without_ptr
COPY target/etc/postfix/postscreen_access /etc/postfix/postscreen_access
COPY target/etc/postfix/submission_header_cleanup /etc/postfix/submission_header_cleanup

COPY target/etc/postfix/sql/mysql_virtual_alias_domain_catchall_maps.cf /etc/postfix/sql/mysql_virtual_alias_domain_catchall_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_alias_domain_mailbox_maps.cf /etc/postfix/sql/mysql_virtual_alias_domain_mailbox_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_alias_domain_maps.cf /etc/postfix/sql/mysql_virtual_alias_domain_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_alias_maps.cf /etc/postfix/sql/mysql_virtual_alias_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_domains_maps.cf /etc/postfix/sql/mysql_virtual_domains_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_mailbox_maps.cf /etc/postfix/sql/mysql_virtual_mailbox_maps.cf
COPY target/etc/postfix/sql/mysql_virtual_sender_maps.cf /etc/postfix/sql/mysql_virtual_sender_maps.cf

EXPOSE 25 587

CMD ["/start.sh"]

