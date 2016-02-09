#!/usr/bin/env bash

dir="$( cd "$( dirname "$0" )" && pwd )"
. $dir/00-config.conf

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

create_container
clean_images
