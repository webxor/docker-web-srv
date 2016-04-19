#!/usr/bin/env bash

##	Function for building new image from Dockerfile
##
##	Params:
##	$1	$image_tag
##
build_docker () {
	echo "START: Build image $1"
	docker build --tag=$1 ./
	echo "DONE: Build image $1"
}

##	Function for creating container from image
##
create_container () {
	echo "START: Creating container '$container_name' from image '$image_tag'"
	docker run -d -t -i \
		-h $hostname \
		-e ROOT_PASSWORD=$root_password \
		-e USER_USERNAME=$user_username \
		-e USER_PASSWORD=$user_password \
		-e MYSQL_ROOT_PASSWORD=$mysql_root_password \
		-e MYSQL_USER_USERNAME=$mysql_user_username \
		-e MYSQL_USER_PASSWORD=$mysql_user_password \
		-e MYSQL_USER_DATABASE=$mysql_user_database \
		-v $mysql_path:/var/lib/mysql \
		-v $home_path:/var/www \
		-p 20080:80 \
		-p 20022:22 \
		--name $container_name \
		--restart=always \
		$image_tag
	echo "DONE: Creating container '$container_name' from image '$image_tag'"
}

##	Function for cleaning unused images in docker
##
clean_images () {
	echo "START: Cleaning unused images"
	docker rmi $(docker images -q -f dangling=true)
	echo "DONE: Cleaning unused images"
}

##	Function for executing BASH in container
##
##	Params:
##	$1	$container_name
##
exec_docker () {
	echo "START: Executing BASH in container '$1'"
	docker exec -it $1 bash
	echo "DONE: Executing BASH in container '$1'"
}

##	Function for killing container
##
##	Params:
##	$1	$container_name
##
kill_container () {
	echo "START: Killing container '$1'"
	docker kill $1
	echo "DONE: Killing container '$1'"
}

##	Function for removing container
##
##	Params:
##	$1	$container_name
##
remove_container () {
	echo "START: Removing container '$1'"
	docker rm $1
	echo "DONE: Removing container '$1'"
}