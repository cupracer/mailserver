FROM registry.suse.com/suse/sle15:15.1
MAINTAINER Thomas Schulte "thomas@cupracer.de"

ARG repo
ARG cert

RUN \
	echo "$cert" > /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT.pem && \
	update-ca-certificates && \
	echo "$repo" > /etc/zypp/repos.d/susemanager:dockerbuild.repo && \
	zypper --non-interactive --gpg-auto-import-keys ref && \
	zypper --non-interactive update && \
	zypper --non-interactive install --no-recommends \
		aaa_base \
		aaa_base-extras \
		less \
		net-tools \
		python \
		python-xml \
		python3 \
		sudo \
		tar \
		timezone \
		vim

###

EXPOSE 3310
CMD ["/start.sh"]

RUN zypper --non-interactive install --no-recommends \
	clamav

COPY target/etc/clamd.conf /etc/clamd.conf
COPY target/etc/freshclam.conf /etc/freshclam.conf

COPY target/start.sh /start.sh

RUN chmod 755 /start.sh

###

RUN zypper clean -a
RUN rm -f /etc/zypp/repos.d/susemanager:dockerbuild.repo

