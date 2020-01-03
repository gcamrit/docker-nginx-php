FROM ubuntu:xenial

LABEL MAINTAINER="Amrit G.C. <music.demand01@gmail.com>"
RUN useradd -ms /bin/bash -u 1337 amritgc

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update

RUN apt-get install -y curl zip unzip git supervisor sqlite3 nginx \
  php7.4 \
  php7.4-fpm \
  php7.4-cli \
  php7.4-bz2 \
  php7.4-bcmath \
  php7.4-imap \
  php7.4-common \
  php7.4-mbstring \
  php7.4-json \
  php7.4-gd \
  php7.4-intl \
  php7.4-mysql \
  php7.4-json \
  php7.4-opcache \
  php7.4-curl \
  php7.4-zip \
  php7.4-xdebug \
  php7.4-xml \
  php7.4-sqlite3 \
  && echo "daemon off;" >> /etc/nginx/nginx.conf

 RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/7.4/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/7.4/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php7.4-fpm start && nginx
