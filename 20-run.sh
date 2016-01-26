#!/bin/bash

image_tag='webxor/websrv'
container_name='websrv'

mysql_data_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mysql_data_path=$mysql_data_path/mysql

echo 'START: Run '$image_tag

docker run -d -t -i \
	-v $mysql_data_path:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD='rootpassword' \
	-p 20080:80 \
	--name $container_name \
	$image_tag

echo 'FINISH: Run '$image_tag

echo 'START: Clean'

docker rmi $(docker images -q -f dangling=true)

echo 'FINISH: Clean'