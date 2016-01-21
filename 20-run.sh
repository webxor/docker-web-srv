#!/bin/bash

docker run -d -t -i \
	-e MYSQL_USER='dbuser' \
	-e MYSQL_PASSWORD='dbpassword' \
	-e MYSQL_ROOT_PASSWORD='rootpassword' \
	-p 20080:80 \
	--name websrv \
	webxor/websrv
