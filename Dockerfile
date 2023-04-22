## Dockerfile for building a docker imapsync image

# Debian Bullseye is Debian 11

FROM php:8.1.18-apache-bullseye

LABEL   maintainer="vajrock <vajrock@gmail.com>" \
        description="Imapsync" \
        documentation="https://github.com/vajrock/imapsync"

# I put a copy of the Dockerfile in the image itself
# It can help maintenance, isn't it?
# Also put optionally my local and usually more recent imapsync on /, for testing purpose

RUN set -xe && \
  apt-get update \
  && apt-get install -y \
  libauthen-ntlm-perl \
  libcgi-pm-perl \
  libcrypt-openssl-rsa-perl \
  libdata-uniqid-perl \
  libencode-imaputf7-perl \
  libfile-copy-recursive-perl \
  libfile-tail-perl \
  libio-compress-perl \
  libio-socket-ssl-perl \
  libio-socket-inet6-perl \
  libio-tee-perl \
  libhtml-parser-perl \
  libjson-webtoken-perl \
  libmail-imapclient-perl \
  libparse-recdescent-perl \
  libmodule-scandeps-perl \
  libpar-packer-perl \
  libreadonly-perl \
  libregexp-common-perl \
  libsys-meminfo-perl \
  libterm-readkey-perl \
  libtest-mockobject-perl \
  libtest-pod-perl \
  libunicode-string-perl \
  liburi-perl  \
  libwww-perl \
  procps \
  wget \
  make \
  cpanminus \
  lsof \
  ncat \
  openssl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && cpanm IO::Socket::SSL

# I added the IO::Socket::SSL update to avoid the annoying, confusing and useless warning
# DEBUG: .../IO/Socket/SSL.pm:1177: global error: Undefined SSL object

RUN set -xe \
  && cd /var/www/html/ \
  && pwd \
  && wget -N --no-check-certificate https://imapsync.lamiral.info/imapsync \
        https://imapsync.lamiral.info/prerequisites_imapsync \
        https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py \
  && chmod +x imapsync oauth2.py 


COPY app/ /var/www/html/

EXPOSE 80

#USER nobody:nogroup

ENV HOME /var/tmp/

WORKDIR /var/tmp/

STOPSIGNAL SIGINT

# CMD ["/app/imapsync"]

# 
# End of imapsync Dockerfile 