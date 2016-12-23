FROM ubuntu:16.04

MAINTAINER MAINTAINER Amrit G.C. <music.demand01@gmail.com>
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

RUN \
  add-apt-repository ppa:ondrej/php && \
  apt-get update \
  apt-get install -y nginx \
  php5 \
  php5-fpm \
  php5-cli \
  php5-common \
  php5-mbstring \
  php5-mcrypt \
  php5-json \
  php5-gd \
  php5-mysql \
  php5-curl \
  php5-zip \
  php5-xml \
  php5-sqlite3 && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf


RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/5.6/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/5.6/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php5.6-fpm start && nginx
