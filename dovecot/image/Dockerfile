FROM opensuse:latest
MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up \
	&& zypper --non-interactive in \
		curl \
		dovecot22-backend-mysql

# We need "rspamc" and therefore need the whole "rspamd" package :-(

RUN rpm --import https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_42.3/repodata/repomd.xml.key \
	&& zypper ar --refresh https://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_42.3/server:mail.repo \
	&& zypper --non-interactive ref \
	&& zypper --non-interactive in \
		rspamd

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
COPY target/etc/dovecot/conf.d/90-sieve-extprograms.conf /etc/dovecot/conf.d/90-sieve-extprograms.conf
COPY target/etc/dovecot/conf.d/90-quota.conf /etc/dovecot/conf.d/90-quota.conf

RUN mkdir -p /usr/local/etc/sieve

COPY target/start.sh /start.sh
COPY target/spam-global.sieve /usr/local/etc/sieve/spam-global.sieve
COPY target/learn-spam.sieve.tpl /usr/local/src/learn-spam.sieve.tpl
COPY target/learn-ham.sieve.tpl /usr/local/src/learn-ham.sieve.tpl
COPY target/rspamc-learn.sh /usr/local/bin/rspamc-learn.sh

RUN chmod 755 /start.sh /usr/local/bin/rspamc-learn.sh

RUN groupadd -r vmail \
	&& useradd -g vmail -d /var/vmail -s /bin/false vmail \
	&& mkdir -p /var/vmail/{mailboxes,sieve/global} \
	&& chown -R vmail: /var/vmail \
	&& chmod -R 770 /var/vmail

RUN chown vmail: /usr/local/etc/sieve

CMD ["/start.sh"]

EXPOSE 24 143 993 3659 4190 10143 10144 12340
