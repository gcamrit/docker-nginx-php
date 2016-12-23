FROM ubuntu:16.04

MAINTAINER MAINTAINER Amrit G.C. <music.demand01@gmail.com>
RUN \
  apt-get update &&\
  apt-get install -y language-pack-en-base \
  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
  apt-get update \
  apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

RUN \

  apt-get install -y nginx \
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
  php5.6-sqlite3 && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf


RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/5.6/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/5.6/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php5.6-fpm start && nginx
