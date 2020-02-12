FROM ubuntu:18.04

LABEL MAINTAINER="Amrit G.C. <music.demand01@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y apt-transport-https ca-certificates

RUN apt-get install -y software-properties-common \
 && apt-add-repository ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y build-essential wget curl zip unzip git supervisor sqlite3 nginx \
  php7.2 \
  php7.2-fpm \
  php7.2-cli \
  php7.2-bz2 \
  php7.2-bcmath \
  php7.2-imap \
  php7.2-common \
  php7.2-mbstring \
  php7.2-json \
  php7.2-gd \
  php7.2-intl \
  php7.2-mysql \
  php7.2-json \
  php7.2-opcache \
  php7.2-curl \
  php7.2-zip \
  php7.2-xdebug \
  php7.2-xml \
  php7.2-sqlite3 \
  && echo "daemon off;" >> /etc/nginx/nginx.conf

 RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/7.2/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/7.2/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php7.2-fpm start && nginx
