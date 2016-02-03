FROM	debian:jessie

MAINTAINER ev.panov@gmail.com

ENV	DEBIAN_FRONTEND noninteractive

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y ssh-server git \
	&& apt-get install -y mysql-server \
	&& apt-get install -y nginx curl wget \
	&& apt-get install -y php5 php5-fpm php5-cli php5-curl php5-mysql php5-memcache php-apc php5-mcrypt php5-imagick \
    && apt-get clean \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer \
    && composer global require hirak/prestissimo \
    && rm -rf /var/lib/mysql
    && rm -rf /var/www

ADD build/nginx.conf /etc/nginx/nginx.conf
ADD build/20-run.sh /root/run.sh

RUN chmod +x /root/run.sh

EXPOSE 22
EXPOSE 80

CMD ["/root/run.sh"]