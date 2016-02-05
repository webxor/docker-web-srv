#!/bin/bash

image_tag='webxor/websrv'
container_name='websrv'

##	Hostname
hostname='websrv'

##	Container root password
root_password='Qq123$%^'

##	MySQL root password
mysql_root_password='Ww123$%^'

##	New user credentials
user_username='newuser'
user_password='Ee123$%^'

host_path="$( cd "$( dirname "$0" )" && pwd )"

mysql_path=$host_path/mysql
home_path=$host_path/www

echo "START: Run $image_tag"

docker run -d -t -i \
	-h $hostname \
	-e ROOT_PASSWORD=$root_password \
	-e MYSQL_ROOT_PASSWORD=$mysql_root_password \
	-e USER_USERNAME=$user_username \
	-e USER_PASSWORD=$user_password \
	-v $mysql_path:/var/lib/mysql \
	-v $home_path:/var/www \
	-p 20080:80 \
	-p 20022:22 \
	--name $container_name \
	$image_tag

echo "FINISH: Run $image_tag"

echo "START: Clean"

docker rmi $(docker images -q -f dangling=true)

echo "FINISH: Clean"