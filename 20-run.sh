#!/bin/bash

image_tag='webxor/websrv'
container_name='websrv'

mysql_root_password='pwd1234%^'
linux_root_password='dD9bs730NJxwh'

host_data_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mysql_data_path=$host_data_path/mysql
www_data_path=$host_data_path/www

echo 'START: Run '$image_tag

docker run -d -t -i \
	-e MYSQL_ROOT_PASSWORD=$mysql_root_password \
	-e LINUX_ROOT_PASSWORD=$linux_root_password \
	-v $mysql_data_path:/var/lib/mysql \
	-v $www_data_path:/var/www \
	-p 20080:80 \
	--name $container_name \
	$image_tag

echo 'FINISH: Run '$image_tag

echo 'START: Clean'

docker rmi $(docker images -q -f dangling=true)

echo 'FINISH: Clean'