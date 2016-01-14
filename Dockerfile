FROM debian:jessie

MAINTAINER ev.panov@gmail.com

ENV DEBIAN_FRONTEND noninteractive

ENV MYSQL_USER $MYSQL_USER
ENV MYSQL_PASSWORD $MYSQL_PASSWORD

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-utils

RUN apt-get install -y nginx curl wget php5 mysql-server mysql-client
RUN apt-get install -y php5-fpm php5-cli php5-curl php5-mysql php5-memcache php-apc php5-mcrypt php5-imagick
RUN apt-get clean

ADD build/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
#EXPOSE 443

CMD ["/usr/sbin/nginx"]
