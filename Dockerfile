FROM ubuntu:16.04

MAINTAINER MAINTAINER Amrit G.C. <music.demand01@gmail.com>

RUN apt-get update && \
  apt-get install -y \
  php5.6 \
  php5.6-fpm \
  php5.6-cli \
  php5.6-common \
  php5.6-mbstring \
  php5.6-mcrypt \
  php5.6-json \
  php5.6-gd \
  php5.6-mysql \
  php5.6-curl \
  php5.6-zip \
  php5.6-xml \
  php5.6-sqlite3 \
  php5.6-opcache

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    apt-get install php7.0-xdebug \
;fi

RUN rm -r /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 9000
CMD ["php-fpm"]

