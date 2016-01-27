FROM	debian:jessie

MAINTAINER ev.panov@gmail.com

ENV	DEBIAN_FRONTEND noninteractive

RUN	apt-get update \
	&& apt-get install -y mysql-server \
	&& apt-get install -y nginx curl \
    && apt-get clean \
    && rm -rf /var/lib/mysql

ADD build/nginx.conf /etc/nginx/nginx.conf
ADD build/20-run.sh /root/run.sh

RUN chmod +x /root/run.sh

EXPOSE 80

CMD ["/root/run.sh"]