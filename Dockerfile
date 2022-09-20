FROM debian:11.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
  && apt install --yes --no-install-recommends \
  apache2 \
  php7.4 \
  php7.4-mysql \
  php7.4-ldap \
  php7.4-xmlrpc \
  php7.4-imap \
  curl \
  php7.4-curl \
  php7.4-gd \
  php7.4-mbstring \
  php7.4-xml \
  php7.4-apcu-bc \
  php-cas \
  php7.4-intl \
  php7.4-zip \
  php7.4-bz2 \
  cron \
  wget \
  ca-certificates \
  jq \
  libldap-2.4-2 \
  libldap-common \
  libsasl2-2 \
  libsasl2-modules \
  libsasl2-modules-db \
  && rm -rf /var/lib/apt/lists/*

COPY glpi-start.sh /opt/
RUN chmod +x /opt/glpi-start.sh
ENTRYPOINT ["/opt/glpi-start.sh"]

EXPOSE 80 443
