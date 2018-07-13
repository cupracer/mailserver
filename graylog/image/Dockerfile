FROM graylog/graylog:3.0

LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"

COPY target/udp-input-gelf.json /usr/share/graylog/data/contentpacks

ENV GRAYLOG_CONTENT_PACKS_AUTO_LOAD udp-input-gelf.json

