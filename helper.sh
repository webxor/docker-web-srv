#!/usr/bin/env bash

##	Function for building new image from Dockerfile
##
##	Params:
##	$1	$image_tag
##
build_docker () {
	echo "START: Build image $1"
	docker build --tag=$1 ./
	echo "FINISH: Build image $1"
}

##	Function for creating container from image
##
##	Params:
##	$1	$container_name
##
create_container () {
	echo "START: Creating container '$1' from image '$image_tag'"
	docker run -d -t -i \
		-h $hostname \
		-e ROOTPASS=$rootpass \
		-e USERNAME=$username \
		-e USERPASS=$userpass \
		-e MYSQL_ROOTPASS=$mysql_rootpass \
		-e MYSQL_USERNAME=$mysql_username \
		-e MYSQL_USERPASS=$mysql_userpass \
		-e MYSQL_DATABASE=$mysql_database \
		-v $mysql_path:/var/lib/mysql \
		-v $home_path:/var/www \
		-p $port_http:80 \
		-p $port_ssh:22 \
		--name $1 \
		--restart=always \
		$image_tag
	echo "FINISH: Creating container '$1' from image '$image_tag'"
}

##	Function for cleaning unused images in docker
##
clean_images () {
	echo "START: Cleaning unused images"
	docker rmi $(docker images -q -f dangling=true)
	echo "FINISH: Cleaning unused images"
}

##	Function for executing BASH in container
##
##	Params:
##	$1	$container_name
##
exec_docker () {
	echo "START: Executing BASH in container '$1'"
	docker exec -it $1 bash
	echo "FINISH: Executing BASH in container '$1'"
}

##	Function for killing container
##
##	Params:
##	$1	$container_name
##
kill_container () {
	echo "START: Killing container '$1'"
	docker kill $1
	echo "FINISH: Killing container '$1'"
}

##	Function for removing container
##
##	Params:
##	$1	$container_name
##
remove_container () {
	echo "START: Removing container '$1'"
	docker rm $1
	echo "FINISH: Removing container '$1'"
}