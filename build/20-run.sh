#!/bin/bash

##	Function for configuring MySQL
##
##	Params
##	$1	$MYSQL_ROOT_PASSWORD
##
function configure_mysql {
	##	Set user:group and init mysql
	if [ ! -d /var/lib/mysql/mysql ]; then
		chown mysql:mysql /var/lib/mysql

		mysql_install_db
	fi

	##	Bind stopping mysql on term signal
	trap "mysqladmin -p$1 shutdown" TERM

	##	Bind address
	mysqld_safe --bind-address=0.0.0.0 &

	##	Waiting start MySQL
	while ! mysqladmin ping -h"0.0.0.0" --silent; do
		sleep 1
	done

	##	Set root password for MySQL
	mysqladmin password "$1"
}

##	Function for configuring web server
##
function configure_web {
	##	Set access to web public dir
	if [ ! -d /var/www/public ]; then
		mkdir -p /var/www/public
		chmod 0750 /var/www/public
		chown www-data:www-data /var/www/public
	fi

	##	Set access to web log dir
	if [ ! -d /var/www/log ]; then
		mkdir -p /var/www/log
		chmod 0750 /var/www/log
		chown www-data:www-data /var/www/log
	fi

	##	Start Nginx
	/usr/sbin/nginx
}

##	Function for configuring server
##
##	Params
##	$1	$LINUX_ROOT_PASSWORD
##
function configure_server {
	##	Set root password for server
	echo "$1" | passwd --stdin
	##	NOTE: Не меняет пароль и падает

	##	Start SSH
	service ssh start
}

##	Function for creating user
##
##	Params
##	$1	$LINUX_USER_NAME
##	$2	$LINUX_USER_PASSWORD
##
function create_user {
	##	Create user
	useradd -M -N -g www-data -s /bin/bash $1

	##	Set password for new user
	echo "$2" | passwd $1 --stdin

	chmod 0750 /var/www
	chown $1:www-data /var/www

	usermod -d /var/www $1
}

configure_mysql $MYSQL_ROOT_PASSWORD
configure_web
configure_server $ROOT_PASSWORD
create_user $USER_USERNAME $USER_PASSWORD

wait



