FROM debian:jessie

ADD  . /src

RUN  apt-get update && apt-get install -y libcurl4-openssl-dev libjansson-dev build-essential libsystemd-journal-dev \
     && cd /src && make \
     && mv journal-gateway-gelf /usr/local/bin \
     && apt-get -y remove build-essential \
     && apt-get -y clean \
     && apt-get -y purge \
     && apt-get -y autoremove \
     && cd / && rm -Rf src

VOLUME /logs

ENV JOURNAL_GELF_REMOTE_TARGET=
ENV JOURNAL_GELF_SOURCE_DIR=/var/log/journal

ENTRYPOINT  ["/usr/local/bin/journal-gateway-gelf"]
