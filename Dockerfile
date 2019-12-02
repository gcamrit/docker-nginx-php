FROM ubuntu:xenial

LABEL MAINTAINER="Amrit G.C. <music.demand01@gmail.com>"
RUN useradd -ms /bin/bash -u 1337 amritgc

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update

RUN apt-get install -y curl zip unzip git supervisor sqlite3 nginx \
  php7.3 \
  php7.3-fpm \
  php7.3-cli \
  php7.3-bz2 \
  php7.3-bcmath \
  php7.3-imap \
  php7.3-common \
  php7.3-mbstring \
  php7.3-json \
  php7.3-gd \
  php7.3-intl \
  php7.3-mysql \
  php7.3-json \
  php7.3-opcache \
  php7.3-curl \
  php7.3-zip \
  php7.3-xdebug \
  php7.3-xml \
  php7.3-sqlite3 \
  && echo "daemon off;" >> /etc/nginx/nginx.conf

 RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/7.3/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/7.3/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php7.3-fpm start && nginx
