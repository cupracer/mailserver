FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
	&& zypper --non-interactive in \
	dovecot22-backend-mysql

COPY target/etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY target/etc/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
COPY target/etc/dovecot/dovecot-dict-sql.conf.ext /etc/dovecot/dovecot-dict-sql.conf.ext
COPY target/etc/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf
COPY target/etc/dovecot/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf
COPY target/etc/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY target/etc/dovecot/conf.d/15-lda.conf /etc/dovecot/conf.d/15-lda.conf
COPY target/etc/dovecot/conf.d/20-imap.conf /etc/dovecot/conf.d/20-imap.conf
COPY target/etc/dovecot/conf.d/20-lmtp.conf /etc/dovecot/conf.d/20-lmtp.conf
COPY target/etc/dovecot/conf.d/20-managesieve.conf /etc/dovecot/conf.d/20-managesieve.conf
COPY target/etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY target/etc/dovecot/conf.d/auth-sql.conf.ext /etc/dovecot/conf.d/auth-sql.conf.ext
COPY target/etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY target/etc/dovecot/conf.d/15-mailboxes.conf /etc/dovecot/conf.d/15-mailboxes.conf
COPY target/etc/dovecot/conf.d/90-sieve.conf /etc/dovecot/conf.d/90-sieve.conf
COPY target/etc/dovecot/conf.d/90-quota.conf /etc/dovecot/conf.d/90-quota.conf

COPY target/start.sh /start.sh
COPY target/spam-global.sieve /var/vmail/sieve/global/spam-global.sieve
COPY target/learn-spam.sieve /var/vmail/sieve/global/learn-spam.sieve
COPY target/learn-ham.sieve /var/vmail/sieve/global/learn-ham.sieve

RUN chmod 755 /start.sh

CMD ["/start.sh"]

EXPOSE 24 143 993 3659 4190 10143 10144 12340

RUN groupadd -r vmail \
	&& useradd -g vmail -d /var/vmail -s /bin/false vmail \
	&& mkdir -p /var/vmail/{mailboxes,sieve/global} \
	&& chown -R vmail: /var/vmail \
	&& chmod -R 770 /var/vmail

