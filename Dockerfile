FROM	debian:jessie

MAINTAINER ev.panov@gmail.com

ENV	DEBIAN_FRONTEND noninteractive

ENV	MYSQL_USER $MYSQL_USER
ENV	MYSQL_PASSWORD $MYSQL_PASSWORD
ENV	MYSQL_ROOT_PASSWORD $MYSQL_ROOT_PASSWORD

RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y apt-utils debconf-utils

RUN	echo mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD | debconf-set-selections && \
	echo mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | debconf-set-selections && \
	apt-get install -y mysql-server

#RUN	mysql -uroot -p$MYSQL_ROOT_PASSWORD && \
#	CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';

RUN	apt-get install -y nginx curl wget mysql-client && \
	apt-get install -y php5 php5-fpm php5-cli php5-curl php5-mysql php5-memcache php-apc php5-mcrypt php5-imagick && \
	apt-get clean

ADD build/nginx.conf /etc/nginx/nginx.conf

RUN	echo 'INSTALLING: Composer' && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer

EXPOSE 80
#EXPOSE 443

CMD ["/usr/sbin/nginx"]
