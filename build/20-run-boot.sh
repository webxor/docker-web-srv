#!/usr/bin/env bash

##	Function for configuring MySQL
##
##	Params
##	$1	$MYSQL_ROOT_PASSWORD
##
configure_mysql () {
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
configure_web () {
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

	service nginx start
}

##	Function for configuring server
##
##	Params
##	$1	$LINUX_ROOT_PASSWORD
##
configure_server () {
	##	Set root password for server
	echo -e "$1\n$1" | passwd

	##	Start SSH
	service ssh start
}

##	Function for creating user
##
##	Params
##	$1	$LINUX_USER_NAME
##	$2	$LINUX_USER_PASSWORD
##
create_user () {
	##	Create user
	useradd -M -N -g www-data -s /bin/bash $1

	##	Set password for new user
	echo -e "$2\n$2" | passwd $1

	chmod 0750 /var/www
	chown $1:www-data /var/www

	usermod -d /var/www $1
}

##	Function for creating user in mysql and create database
##
##	Params:
##	$1	$MYSQL_ROOT_PASSWORD
##	$2	$MYSQL_USER_USERNAME
##	$3	$MYSQL_USER_PASSWORD
##	$4	$MYSQL_USER_DATABASE
##
create_mysql_user () {
	mysql -uroot -p$1 -e "
		CREATE DATABASE IF NOT EXISTS $4;
		GRANT USAGE ON *.* TO $2@localhost IDENTIFIED BY '$3';
		GRANT ALL PRIVILEGES ON $4.* TO $2@'localhost';
		FLUSH PRIVILEGES;"
}

configure_mysql $MYSQL_ROOT_PASSWORD
configure_web
configure_server $ROOT_PASSWORD
create_user $USER_USERNAME $USER_PASSWORD
create_mysql_user $MYSQL_ROOT_PASSWORD $MYSQL_USER_USERNAME $MYSQL_USER_PASSWORD $MYSQL_USER_DATABASE

/usr/bin/supervisord
