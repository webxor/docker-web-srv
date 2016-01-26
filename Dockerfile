FROM	debian:jessie

MAINTAINER ev.panov@gmail.com

ENV	DEBIAN_FRONTEND noninteractive

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils debconf-utils \
	&& apt-get install -y mysql-server \
	&& apt-get install -y nginx curl wget mysql-client \
    && apt-get install -y php5 php5-fpm php5-cli php5-curl php5-mysql php5-memcache php-apc php5-mcrypt php5-imagick \
    && apt-get clean \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer \
    && rm -rf /var/lib/mysql

ADD build/nginx.conf /etc/nginx/nginx.conf
ADD build/20-mysql-start.sh /root/mysql-start.sh
ADD build/20-mysql-passwd.sh /root/mysql-passwd.sh

RUN chmod +x /root/mysql-start.sh \
	&& chmod +x /root/mysql-passwd.sh

EXPOSE 80

CMD ["/root/mysql-start.sh"]
CMD ["/root/mysql-passwd.sh"]
CMD ["/usr/sbin/nginx"]