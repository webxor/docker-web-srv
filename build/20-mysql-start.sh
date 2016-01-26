#!/bin/bash

#	Set user:group and init mysql
if [ ! -d /var/lib/mysql/mysql ]; then
	chown mysql:mysql /var/lib/mysql
    mysql_install_db
fi

trap "mysqladmin -p$MYSQL_ROOT_PASSWORD shutdown" TERM
mysqld_safe --bind-address=0.0.0.0 &
wait