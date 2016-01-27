#!/bin/bash

#	Set user:group and init mysql
if [ ! -d /var/lib/mysql/mysql ]; then
	chown mysql:mysql /var/lib/mysql

    mysql_install_db
fi

#	Bind stopping mysql on term signal
trap "mysqladmin -p$MYSQL_ROOT_PASSWORD shutdown" TERM

#	Bind address
mysqld_safe --bind-address=0.0.0.0 &

#	Waiting start MySQL
while ! mysqladmin ping -h"0.0.0.0" --silent; do
	sleep 1
done

#	Set root password for MySQL
mysqladmin password "$MYSQL_ROOT_PASSWORD"

#	Start Nginx
/bin/sh -c /usr/sbin/nginx

wait



