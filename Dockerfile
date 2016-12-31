FROM ubuntu:16.04

MAINTAINER MAINTAINER Amrit G.C. <music.demand01@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y language-pack-en-base &&\
    export LC_ALL=en_US.UTF-8 && \
    export LANG=en_US.UTF-8


RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php


RUN DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 \
    apt-get update && apt-get install -y 

RUN \
  apt-get install -y git curl nginx \
  php7.1 \
  php7.1-fpm \
  php7.1-cli \
  php7.1-common \
  php7.1-mbstring \
  php7.1-mcrypt \
  php7.1-json \
  php7.1-gd \
  php7.1-mysql \
  php7.1-curl \
  php7.1-zip \
  php7.1-xml \
  php7.1-sqlite3 && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf


RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/7.1/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/7.1/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php7.1-fpm start && nginx
